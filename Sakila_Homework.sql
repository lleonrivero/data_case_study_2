USE sakila;
# Get all the data from tables actor, film and customer
# Option 1: separate tables
SELECT *
FROM actor;
SELECT *
FROM film;
SELECT *
FROM customer;
# Option 2: one single table
SELECT *
FROM actor, film, customer;
# Get film titles
SELECT title 
FROM film;
# Get unique list of film languages under the alias language
SELECT name language
FROM language;
# Find out how many stores does the company have?
SELECT sum(store_id)
FROM store; 
# NOTE: There is a 'null' row in store table. Sum(store_id) is 3, but there are actually only 2 stores.
SELECT store_id FROM store;
SELECT *  FROM store WHERE store_id IS NULL; # This one is only showing rows with 'null' values in store_id
SELECT *  FROM store WHERE store_id IS NOT NULL; # This one should not be showing those rows, but they are still showing
# Find out how many employees staff does the company have?
SELECT sum(staff_id)
FROM staff;
# Return a list of employee first names only?
SELECT first_name
FROM staff;

