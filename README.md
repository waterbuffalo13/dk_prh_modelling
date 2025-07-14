# Data Platform Engineer Technical Assessment: Data Modelling & Transformation

## Data Model Justification:
### Design Decision #1: Normalising into Facts and Dimensions

I chose to break the dataset into the following six dimensions:
  - **Area[AREA_KEY, AREA_NUMBER, STORE_KEY]**
    - Understand the geographic region the product was sold in
    - STORE_KEY foreign key to include access to store level
  - **Author[AUTHOR_KEY, FULL_NAME, FIRST_NAME, LAST_NAME ] **
    -   In RAW_SALES, the authors are listed as an array which makes it hard to track which authors are involved in the creation of which books (only unique combinations will be tracked instead)
    -   One author can write many books, and a book can be written by many authors
    -   Prices and titles may change over time (e.g. their price)
    -   New versions may be released and books may have the same name
  - **Book[BOOK_KEY, BOOKAUTHOR_KEY, PUBLISHER_KEY, BOOK_ISBN, BOOK_TITLE, AVAILABILITY, CORE_STOCK_FLAG, PUBLICATION_DATE**
    - Nearly every instance of the same book had the same CORE_STOCK_FLAG, so i included it in the book table
    - Availability is too small to normalise out, but potentially belongs in a junk dimension.
  -  **BookAuthors[BOOKAUTHOR_KEY,AUTHOR_KEY, BOOK_KEY, BOOK_TITLE]**
    - Precalculates what authors are mapped to what books
  - **Category[CATEGORY_KEY, PRODUCT_GROUP, DEPARTMENT, SUB_DEPARTMENT, CLASS]**
  - **Store[STORE_KEY, STORE_NUMBER, STORE_NAME, AREA_KEY]**
  - **Publisher[PUBLISHER_KEY, NAME, IMPRINT]**

As well as into the following fact tables:
    - **FactSales: A unified table to keep track of sales and returns that occur across the business**
      - Finances are the most important thing to keep track of within a business.
    - **FactInventory: A table to keep track of QTY_ON_HAND, QTY_ON_ORDER and QTY_RECIEVED.**
      - Considered further segmenting into FactOrders but need more information on how orders are processed

### Design Decision #2: Using dbt_utils.generate_surrogate_key as the primary identifier
The benefits of this approach include:
    - Simplifies join logic (by hashing multiple columns into a single one).
    - Deterministic so same input produces same keys

However:
    - Possibility of hash collisions
    - Potentially slower then an auto-incrementing integer
    - If a person changes there name, then surrogate key will change and 

#Project Overview
Staging:
    - STORE_SALES_CLEANED: The original csv but with new names, casted datatypes (e.g. authors to variant), and cleaned values

Mart:
  - **DIM_AUTHOR: Extracts people who have created a book that has been sold**
  - **DIM_BOOK: The item/product that has either been ordered/sold/returned.**
  - **DIM_CATEGORY: The various categories and subcategories a book may fall into.**
  - **DIM_STORE: A place where books are sold.**
  - **DIM_AREA: The geographical boundaries where groups of stores are located in**
  - **FACT_BOOKAUTHORS: A mapping of which authors have written what books**
  - **DIM_PUBLISHER: The company and imprint that organised the production, distribution and organisation of the book** 

#Data Quality 
#Assumptions & Challenges
#Bonus Questions
