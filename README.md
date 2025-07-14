# Data Platform Engineer Technical Assessment: Data Modelling & Transformation

# Data Model Justification:
## Design Decision #1: Highly normalised into 6 dimensions! (Area, Author, Book, Genre, Publisher, Store) for further reporting

Excluding maintianing data integrity and data redundancy, is to break the dataset down into seperate tables that are worth studying in further detail.

I chose to break the dataset into six entities for the following reason: 
  - Area:
    - Definitions may change or be augmented over time 
    - Important for slicing against sales and books for insight
    - Duplication of AREA_NUMBER AND AREA_NAME attributes
  - Author:
    -   Indicates the person responsible  
    -   Keep track of which authors write what books as authors are listed as an array which if unprocessed will 
    -   One author can write many books, and a book can be written by many authors
  - Book:
    - Indicates the item being sold
    - Prices may change over time (e.g. their price)
  - Genre: Books belong in specific categories and these categories may also change or evolve over time. So it's much easier to update a product in the dimension instead of the giant fact table
  - Store: Exists as a seperate distinct logical entity, and prevents the repeti
## Decision Decision #2: 2 Fact Tables




#Project Overview
#Data Quality 
#Assumptions & Challenges
#Bonus Questions
