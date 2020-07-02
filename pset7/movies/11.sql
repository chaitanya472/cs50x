/*
Outputs the 5 highest rated movies that Chadwick Boseman starred in starting with the highest rated
*/

SELECT title FROM movies JOIN ratings ON movies.id = ratings.movie_id WHERE id IN
(SELECT movie_id FROM stars where person_id IN
(SELECT id from people WHERE name = "Chadwick Boseman"))
ORDER BY rating DESC LIMIT 5;