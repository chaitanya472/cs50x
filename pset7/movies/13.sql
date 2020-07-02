/*
Outputs all of the people who stared in a movie that the Kevin Bacon born on 1958 also starred in 
*/

SELECT name FROM people WHERE id in
(SELECT person_id FROM stars WHERE movie_id in
(SELECT movie_id FROM stars WHERE person_id =
(SELECT id FROM people WHERE name = "Kevin Bacon" AND birth = 1958))) 
AND name != "Kevin Bacon";