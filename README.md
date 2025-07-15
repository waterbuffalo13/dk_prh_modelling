# Data Platform Engineer Technical Assessment: Data Modelling & Transformation

## Data Model Justification:
### Design Decision #1: Normalising into Facts and Dimensions

I chose to break the dataset into the following seven dimensions:
  - **Area[AREA_KEY, AREA_NUMBER, AREA_NAME]**
    - Understand the geographic region the product was sold in
  - **Author[AUTHOR_KEY, FULL_NAME, FIRST_NAME, LAST_NAME ]**
    -   In RAW_SALES, the authors are listed as an array which makes it hard to track which authors are involved in the creation of which books (only unique combinations will be tracked instead)
    -   One author can write many books, and a book can be written by many authors
    -   Prices and titles may change over time (e.g. their price)
    -   New versions may be released and books may have the same name
  - **Book[BOOK_KEY, BOOK_ISBN, PUBLISHER_NAME, AUTHORS, CATEGORY_KEY, BOOK_NAME, PRICE, AVAILABILITY, CORE_STOCK_FLAG, PUBLICATION_DATE**
    - Nearly every instance of the same book had the same CORE_STOCK_FLAG, so i included it in the book table
    - Availability is too small to normalise out, but potentially belongs in a junk dimension.
  -  **BookAuthors[BOOKAUTHOR_KEY,AUTHOR_KEY, BOOK_KEY]**
    - Precalculates what authors are mapped to what books
  - **Category[CATEGORY_KEY, PRODUCT_GROUP, DEPARTMENT, SUB_DEPARTMENT, CLASS]**
  - **Store[STORE_KEY, STORE_NUMBER, STORE_NAME, AREA_KEY]**
  - **Publisher[PUBLISHER_KEY, NAME, IMPRINT]**

As well as into the following fact tables: 
- **FactSales: A unified table to keep track of sales and returns that occur across the business** 
    - Finances are the most important thing to keep track of within a business.
- **FactInventory: A table to keep track of QTY_ON_HAND, QTY_ON_ORDER and QTY_RECIEVED.**

And one analytical model:
- **Highest_grossing_books_per_store: To provide easy access to the main business question**

Considered dimensions:
- **FactOrders: Potentially a good abstraction but not enough information to map QTY_ON_ORDER to QTY_RECIEVED)**
- **DimAvailability: Too small to normalise out by itself, but would fit will in a junk dimension**


### Design Decision #2: Using dbt_utils.generate_surrogate_key as the primary identifier
The main benefit of this approach is that it supports changes to the business key i.e. if the area number refers to a different area in new incoming transactions, then both the prior and the new area number changes can be catalogued in DIM_AREA with the relevant changes.
However it would be slower then joining two integer-based business keys and there's a small chance of hash collisions.

## Project Overview
Staging:
    - STORE_SALES_CLEANED: The original csv but with new names, casted datatypes (e.g. authors to variant), and cleaned values

Mart:
  - **DIM_AUTHOR: Extracts people who have created a book that has been sold**
  - **DIM_BOOK: E item/product that has either been ordered/sold/returned.**
  - **DIM_CATEGORY: The various categories and subcategories a book may fall into.**
  - **DIM_STORE: A place where books are sold.**
  - **DIM_AREA: The geographical boundaries where groups of stores are located in**
  - **DIM_BOOKAUTHORS: A mapping of which authors have written what books**
  - **DIM_PUBLISHER: The company and imprint that organised the production, distribution and organisation of the book** 
  - **FACT_SALES: A unified table to keep track of sales and returns that occur across the business** 
  - **FACT_INVENTORY: A table to keep track of QTY_ON_HAND, QTY_ON_ORDER and QTY_RECIEVED.**

# Testing & Data Quality:

Tests are applied at two levels, within the schema.yml files in each directory for basic tests (e.g. isNull, valid relationships) and within the /tests files
- Schema.yml Basic Checks
    - NOT NULL Checks: Ensure each column contains values
    - UNIQUE Checks: No duplicate transactions
    - REFERENTIAL INTEGRITY: KEYS from Dimensions always map to a corresponding value within the FACT KEYS
- Custom/Tests Checks
    - NO_NEGATIVE_QTY: Ensure QTY_ON_HAND, QTY_ON_ORDER, QTY_RECIEVED, QTY_SOLD is a positive integer
    - UNIT_OUT_OF_BOUNDS: Ensure book price exists at a reasonable amount
    - VALID_SALE_DATE; Ensure that the dates imported do not refer to dates that have not occurred or in the past 
    - ZERO_QTY_ZERO_AMOUNT: That the price is a non-zero amount
# Assumptions & Challenges
Assumptions:
- That this is the only information in the data warehouse and cannot be enriched/validated with alternative sources
- The business logic behind many of the dataset columns e.g. CORE_FLAG_STOCK
- Determining the Sales Amount as RRP * QTY_SOLD 
- Incoming data will not contain any NULL values
- Duplicate entries are not possible (QTY_ON_HAND) could/should change after a transactions

Challenges:
- Meeting 100% testing coverage goals for a variety of unusual situations
- Choosing whether to normalise or denormalise entities
- Understanding the best approach to handle many to many relationships
- Connecting snowflake to DBT (finding the right account name)
- Removing the auto-generated schema name generated using my DBT account name
- Importing dbt_utils
  
Bonus Question (Optional): 
Briefly describe how you would modify your model to run incrementally.

STEP 1: set materialisation to incremental, and the unique key to the surrogate key
STEP 2: Add is_incremental() block so that you only get new data every time the model is run
STEP 3: Run models with full refresh, then subsequent runs should only pull in new data

So when RAW.STORE_SALES is loaded with new data, when the model it will only pull new data in.
