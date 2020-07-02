/*
Outputs the number of movies with a rating of 10.0
*/

SELECT COUNT(title) FROM movies WHERE id in (SELECT movie_id FROM ratings WHERE rating = 10.0);