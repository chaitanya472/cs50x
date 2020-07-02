/*
Outputs the title and rating for each movie released on 2010 that has a rating
in descending order by rating
For movies with the same rating they are ordered alphabetically
*/

SELECT movies.title, ratings.rating FROM movies
JOIN ratings ON movies.id = ratings.movie_id WHERE year = 2010 AND rating IS NOT NULL
GROUP BY title ORDER BY rating DESC;