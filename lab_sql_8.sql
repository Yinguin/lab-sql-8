USE sakila;

# 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, DENSE_RANK() OVER (ORDER BY length DESC) AS "length_ranking"
FROM film
WHERE length > 0;

# 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, DENSE_RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS "length_ranking"
FROM film
WHERE length > 0;

# 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT C.category_id, C.name, COUNT(F.film_id) AS num_of_films
FROM category C
INNER JOIN film_category F
ON C.category_id = F.category_id
GROUP BY C.category_id;

# 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT A.actor_id, A.first_name, A.last_name, COUNT(F.film_id) AS num_of_films
FROM actor A
INNER JOIN film_actor F
ON A.actor_id = F.actor_id
GROUP BY A.actor_id
ORDER BY num_of_films
LIMIT 1;

# 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT C.customer_id, C.first_name, C.last_name, COUNT(R.rental_id) AS num_of_rentals
FROM customer C
INNER JOIN rental R
ON C.customer_id = R.customer_id
GROUP BY C.customer_id
ORDER BY num_of_rentals
LIMIT 1;

# Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
SELECT F.film_id, F.title, COUNT(R.inventory_id) AS num_of_rentals
FROM film F
JOIN inventory I ON F.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
GROUP BY film_id
ORDER BY num_of_rentals DESC
LIMIT 1;
