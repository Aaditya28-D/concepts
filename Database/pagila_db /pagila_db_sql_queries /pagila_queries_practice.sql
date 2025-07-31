-- first and last name of the customers 
SELECT first_name, last_name
FROM customer;

--show first name and last name of the customer of store 1
SELECT first_name, last_name
FROM customer
WHERE store_id=1;


-- show the first name, last name of all customers, sorted by last name.
SELECT first_name, last_name
FROM customer
ORDER BY last_name DESC;

--get a list of all unique districts where customers live 
SELECT DISTINCT district
FROM address;

-- count how many customers are in each store 
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id;

-- show store ids that have more than 300 customers 
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id
HAVING COUNT(*)>300;

-- list the number of customers per store, ordered from least to most 
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id
ORDER BY customer_count ASC; 

-- list all customers from store 1, ordered by last name descending
SELECT first_name, last_name
FROM customer
WHERE store_id=1 
ORDER BY last_name DESC;

--show the number of customers per store where the store is not 2 and only include stores wht more than 300 customers. sort result by count descending
SELECT store_id, COUNT(*) AS customer_count
FROM customer
WHERE store_id !=2
GROUP BY store_id
HAVING COUNT(*) >300
ORDER BY customer_count DESC;


--practice tasks (set1)
-- show the title and release_year of all films relased in 2006
SELECT title, release_year
FROM film
WHERE release_year =2006;

--list the first_name and last_name of customers from store 2 sorted by first_name 
SELECT first_name, last_name
FROM customer
WHERE store_id=2
ORDER BY first_name;

--how many customers are there per store? show store_id and customer_count
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id;

-- list only those stores that have more than 350 customers. show store_id and customer_count
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id
HAVING COUNT(*)>350;

-- show all unique postal_code values from the address table 
SELECT DISTINCT postal_code
FROM address;


--practice set 2
-- list the first and last name of customers whose first name starts with "A" 
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'A%';

--show the number of addesses per district, sorted in descending order of address count 
SELECT district, COUNT(*) AS address_count
FROM address
GROUP BY district
ORDER BY address_count DESC;

-- list the store_id and the number of rentals made from each store
SELECT inventory.store_id, COUNT(*) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id=inventory.inventory_id
GROUP BY inventory.store_id;


-- show all the unique film ratings in the film table
SELECT DISTINCT rating
FROM film;

-- find how many films are in each rating category (e.g., PG, G, R), but only show those ratings that have more than 200 films 
SELECT rating, COUNT(*) AS films_count
FROM film
GROUP BY rating
HAVING COUNT(*)>200;


--set 3
-- show the title and length of all films longer than 180 minutes, ordered by length in descending order
SELECT title, length
FROM film
WHERE length>180
ORDER BY length DESC;

-- list the district and number of customers liviing in each district. Only include districts with at least 5 customers.
SELECT district, COUNT(customer.customer_id) AS customer_count
FROM customer
JOIN address ON customer.address_id=address.address_id
GROUP BY district
HAVING COUNT(customer.customer_id)>5
ORDER BY customer_count DESC;

--show the top 5 films with the highest rental rates. Display title and rental rate
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;


--list each rating category and the averge film length in that category, rounded at 2 decimal places 
SELECT rating, Round(AVG(length), 2) AS average_film_length
FROM film
GROUP BY rating
ORDER BY average_film_length DESC;


-- get a list of unique city names where the stores are located
SELECT city.city, COUNT(store.store_id) AS store_count_per_city
FROM store
JOIN address ON store.address_id= address.address_id
JOIN city ON address.city_id=city.city_id
GROUP BY city.city
ORDER BY store_count_per_city DESC;


-- set 4
--list the title and replacement_cost of all films that cost more than $25 to replace, soreted by cost descending 
SELECT title, replacement_cost
FROM film
WHERE replacement_cost>25
ORDER BY replacement_cost DESC;

-- show the district and total number of stores in each district. only include districts with more than one store 
SELECT district, COUNT(store_id) AS store_count_per_district
FROM store
JOIN address ON store.address_id=address.address_id
GROUP BY district
HAVING COUNT(store_id)>1;

-- find the first_name, last_name and number of rentals made by each customer
SELECT first_name, last_name, COUNT(rental_id) AS rental_count_per_customer
FROM customer
JOIN rental ON customer.customer_id=rental.customer_id
GROUP BY customer.customer_id
HAVING COUNT(rental_id)>=20
ORDER BY rental_count_per_customer DESC;

--list the number of staff members per store, sorted by staff count descending
SELECT store.store_id, COUNT(staff.staff_id) AS staff_per_store
FROM store
JOIN staff ON store.store_id=staff.store_id
GROUP BY store.store_id
ORDER BY staff_per_store DESC;

--Display the number of films per language. show language. name and film count.
SELECT language.name, COUNT(film_id) AS films_per_language
FROM film
JOIN language ON film.language_id=language.language_id
GROUP BY language.name;




