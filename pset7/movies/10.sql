/*
Outputs all people who directed a movie that got a rating of at least 9.0
*/

SELECT name FROM people WHERE id in
(SELECT person_id FROM directors WHERE movie_id in
(SELECT movie_id FROM ratings WHERE rating >= 9.0));