/*
Outputs the names of all of the people who stared in Toy Story
*/

SELECT name FROM people WHERE id in 
(SELECT person_id FROM stars WHERE movie_id = 
(SELECT id from movies where title = "Toy Story"));