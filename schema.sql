--Create a schema.sql file with tables that will be analogical to the structure of the classes that we created

-- Create the 'genres' table
CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);
