-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT name, release_year, worldwide_gross
FROM 
USING (movie_id)
ORDER BY worldwide_gross ASC

-- Answer: Semi Tough


-- 2. What year has the highest average imdb rating?
SELECT 
	specs.release_year, AS avg__imbd_rating
FROM specs
GROUP BY specs.release_year
ORDER BY avg_imbd_rating desc

-- Answer: 1991


-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT
	lt1.mpaa_rating,
	revenue.worldwide_gross,
	rt2.company_name
FROM specs AS lt1
LEFT JOIN worldwide_gross
USING reenue

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT 
       COUNT(movie_id) AS total_movies,
	   distributors, company_name
FROM specs
FULL JOIN distributors
ON specs, domestic_distributor_id = distributors.distributer_id
GROUP BY distributors, company_name
ORDER BY total_movies 


-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT d.distributor_name,
       AVG(m.budget) AS avg_budget
FROM distributors d
JOIN movies m
  ON d.distributor_id = m.distributor_id
GROUP BY d.distributor_name
ORDER BY avg_budget DESC
LIMIT 5;

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT COUNT (movie_id)
FROM distributors AS lt1
INNER JOIN specs AS rt2
ON lt1.distributor_id=rt2.domestic_distributor_id
AND headquarters NOT IN
	(SELECT headquarters
	FROM distributors
	WHERE headquarters = 'CA')

SELECT 
    CASE 
        WHEN runtime_minutes > 120 THEN 'Over 2 hours'
        ELSE '2 hours or less'
    END AS movie_length_category,
    AVG(imdb_rating) AS avg_rating
FROM movies
GROUP BY movie_length_category;
