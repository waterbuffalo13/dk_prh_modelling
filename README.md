# Data Platform Engineer Technical Assessment: Data Modelling & Transformation

# Data Model Justification:
## Design Decision #1:  Choice of Dimensions (Area, Author, Book, Genre, Publisher, Store) 

I chose to break the dataset into six entities for the following reason: 
  - **Area: The geographic region where products are sold in.**
    -   Definitions may change or be augmented over time 
    -   Important for slicing against sales and books for insight
    -   Duplication of AREA_NUMBER and AREA_NAME attributes
  - **Author: A person who has created a book that has been sold**
    -   Keep track of which authors write what books
    -   In RAW_SALES, the authors are listed as an array which makes it hard to track which authors are involved in the creation of which books (only unique combinations will be tracked instead)
    -   One author can write many books, and a book can be written by many authors
  - **Book: The item/product that has either been ordered/sold/returned.**
    -   Prices and titles may change over time (e.g. their price)
    -   New versions may be released and books may have the same name
  - **Genre: The various categories and subcategories a book may fall into.**
    -   Categories may change over time based on the nature of books sold and business changes
    -   Centralised place to modify your categories (modify once in the genre, instead of applying a giant update statement in the RAW table)
  - **Store: A place where books are sold.**
    -   Makes it easy to keep track of DK's sales channels and how this evolves over time
    -   Understanding what makes a particular store more profitable then another
## Decision Decision #2: 2 Fact Tables


#Project Overview
#Data Quality 
#Assumptions & Challenges
#Bonus Questions
