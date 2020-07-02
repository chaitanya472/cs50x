/*
Outputs the titles for all movies released on or after 2018 in alphabetic order
*/

SELECT title FROM movies WHERE year >= 2018 ORDER BY title;