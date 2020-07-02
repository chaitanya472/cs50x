/*
Outputs the names of people  who stared in a move that was realeased on 2004 orderd by birth year
No names are stated more then once
*/

SELECT name FROM people WHERE id in 
(SELECT DISTINCT person_id FROM stars WHERE movie_id in 
(SELECT id FROM movies WHERE year = 2004)) ORDER BY birth;