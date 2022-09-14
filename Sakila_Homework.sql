## LAB SQL INTRO ##

USE sakila;
-- Get all the data from tables actor, film and customer
-- Option 1: separate tables
SELECT *
FROM actor;
SELECT *
FROM film;
SELECT *
FROM customer;
-- Option 2: one single table
SELECT *
FROM actor, film, customer;
-- Get film titles
SELECT title 
FROM film;
-- Get unique list of film languages under the alias language
SELECT name language
FROM language;
-- Find out how many stores does the company have?
SELECT COUNT(store_id)
FROM store; 
-- NOTE: There is a 'null' row in store table. Sum(store_id) is 3, but there are actually only 2 stores.
SELECT store_id FROM store;
SELECT *  FROM store WHERE store_id IS NULL; -- This one is only showing rows with 'null' values in store_id
SELECT *  FROM store WHERE store_id IS NOT NULL; -- This one should not be showing those rows, but they are still showing
-- Find out how many employees staff does the company have?
SELECT COUNT(staff_id)
FROM staff;
-- Return a list of employee first names only?
SELECT first_name
FROM staff;

## Lab | SQL Queries - Lesson 2.5 ##

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT first_name, last_name FROM actor 
WHERE first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?
DESC film;
DESC inventory;
SELECT COUNT(*) AS 'Available titles' FROM sakila.film ; -- 1000 titles available
SELECT COUNT(*) AS 'Inventory' FROM sakila.inventory; -- 4581 films in inventory (one film can have multiple physical copies) 
DESC rental;
SELECT COUNT(rental_date) AS 'Rentals to date' FROM sakila.rental; -- 16046 rentals so far
SELECT COUNT(return_date) AS 'Returns to date' FROM sakila.rental; -- 15861 films returned
SELECT (COUNT(rental_date) - COUNT(return_date)) AS 'Current rentals' FROM sakila.rental; -- 185 films rented at the moment

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
DESC film;
SELECT MAX(length) AS 'max_duration' FROM sakila.film; -- 185 min.
SELECT MIN(length) AS 'min_duration' FROM sakila.film; -- 46 min.

-- 4. What's the average movie duration expressed in format (hours, minutes)? -- Not sure how to convert this in a clean way. 
SELECT ROUND(avg(length)) AS 'avg_duration' FROM sakila.film;
SELECT concat(floor((AVG(length))/60),":",round((AVG(length))%60,0)) AS "average_length" 
from sakila.film;


-- 5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(last_name)) FROM sakila.actor; -- 121

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT * FROM sakila.rental;
SELECT DATEDIFF(MAX(last_update), MIN(rental_date)) AS 'Operating time (in days)' FROM sakila.rental; -- Output is 5312. See NOTE below.

-- NOTE: My Sakila database includes 2 extra rows that are not present in other Sakila databases. 
-- That is why the difference between MAX(last_update) and MIN(rental_date) is different. But the code is correct. 

-- 7. Show rental info with additional columns month and weekday. Get 20 results. -- SUBSTR(string, start, length)
SELECT * FROM sakila.rental;
SELECT *, SUBSTR(rental_date, 1,4) AS 'Year', SUBSTR(rental_date, 6,2) AS 'Month', SUBSTR(rental_date, 9, 2) AS 'Weekday' FROM sakila.rental
LIMIT 20;
SELECT *, DATE_FORMAT(CONVERT(LEFT(rental_date,4),date), '%d-%m-%Y') AS 'issued_date' FROM sakila.rental;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, SUBSTR(rental_date, 1,4) AS 'Year', SUBSTR(rental_date, 6,2) AS 'Month', SUBSTR(rental_date, 9, 2) AS 'Weekday' FROM sakila.rental
LIMIT 20;

-- 9. Get release years.
SELECT title AS 'Title', release_year AS 'Release year' FROM film; 
SELECT DISTINCT(release_year) FROM film; -- All films where released on the same year: 2006.

-- 10 .Get all films with ARMAGEDDON in the title.
SELECT title AS 'Title' FROM sakila.film WHERE title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO.
SELECT * FROM sakila.film;
SELECT title, RIGHT(title, 6) AS 'Ending' FROM sakila.film
WHERE title LIKE '%APOLLO'; 

-- 12. Get 10 the longest films.
SELECT title, length FROM sakila.film 
ORDER BY length DESC
LIMIT 10; 

-- 13. How many films include Behind the Scenes content?
SELECT DISTINCT(special_features) FROM sakila.film;
SELECT count(*) AS 'Behind the scenes' FROM sakila.film
WHERE special_features LIKE ('%Behind the scenes%'); -- Total of 538 films


##Lab | SQL Queries - Lesson 2.6##

-- 1.  In the table actor, which are the actors whose last names are not repeated? 
-- For example if you would sort the data in the table actor by last_name, 
-- you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
-- These three actors have the same last name. So we do not want to include this last name in our output. 
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
SELECT last_name, first_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

-- 2. Which last names appear more than once? 
-- We would use the same logic as in the previous question but this time we want to 
-- include the last names of the actors where the last name was present more than once.
SELECT last_name FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) >= 2;

-- 3. Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id AS 'Employee', COUNT(rental_id) AS 'Rentals Processed' FROM sakila.rental
GROUP BY staff_id;

-- 4. Using the film table, find out how many films were released each year.
SELECT count(*) AS 'Number of films', release_year AS 'Release Year' FROM sakila.film
GROUP BY release_year;

-- 5. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places.
SELECT round(avg(length), 2) AS 'Mean length', rating AS 'Rating' FROM sakila.film
GROUP BY rating;

-- 6. Which kind of movies (rating) have a mean duration of more than two hours?
SELECT round(avg(length), 2) AS 'Mean length', rating AS 'Rating' FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;


-- 7. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
-- Option 1: RANK()
SELECT RANK() OVER(ORDER BY length DESC) AS 'Rank', title AS 'Title', length AS 'Length' FROM sakila.film
WHERE length > 0 AND length IS NOT NULL
ORDER BY length DESC;

-- Option 2: DENSE_RANK()
SELECT DENSE_RANK() OVER(ORDER BY length DESC) AS 'Rank', title AS 'Title', length AS 'Length' FROM sakila.film
WHERE length > 0 AND length IS NOT NULL
ORDER BY length DESC;
