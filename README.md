# Data Platform Engineer Technical Assessment: Data Modelling & Transformation

# Data Model Justification:
## Design Decision #1: Highly normalised into 6 dimensions! (Area, Author, Book, Genre, Publisher, Store) for further reporting
I chose to break the dataset into the following dimensions for the following reasons: \
  - Area: The geographical attributes of the stores is important for certain calculations and visualisations (e.g. geomapping) and the logic behind which stores fall into what groups could change or be augmented over time and so it helps to have a table to reflect this.
  - Author: Abstracted out of Book entity because without proper normalisation it becomes difficult to track which authors are responsible for what books (as they may co-write many books with many different people making it difficult to tracke).
  - Book: Books (and products in general) are distinct objects that are sold with attributes that can change over time (e.g. their price) and would be useful to calculate against other data e.g. sales information. 
  - Genre: Books belong in specific categories and these categories may also change or evolve over time. So it's much easier to update a product in the dimension instead of the giant fact table
  - Store: The number of stores across



#Project Overview
#Data Quality 
#Assumptions & Challenges
#Bonus Questions
