/*
Outputs the average rating of all movies realeased on 2012
*/

SELECT AVG(rating) from ratings where movie_id IN (SELECT id from movies where year = 2012);