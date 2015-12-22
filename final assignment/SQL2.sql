-- a. average age of directors

select  2015-avg("Directors"."Year_of_birth") AS "Age"
from "Directors";

-- a results:
--
--          Age         
-- ---------------------
--  60.5000000000000000
-- (1 row)

-- b. number of countries that actors in Inception were born

select count("CityID") from "Actors"
join "Cities" using ("CityID")
join "States" using ("StateID")
join "Movie Actors" using ("ActorID")
join "Movies" using ("MovieID")
where "Movie_title" = 'Inception';

-- b results:
--
--  count 
-- -------
--      1
-- (1 row)

-- c. number of actors with green eyes

select count ("Actors"."Eye_colour") from "Actors"
where "Eye_colour" = 'Green';

-- c results:
--
--  count 
-- -------
--      2
-- (1 row)

-- d. number of movies with Halle Berry

select count(*) from "Movies" 
join "Movie Actors" using ("MovieID")
join "Actors" using ("ActorID")
where "Actors"."First_name" = 'Halle' and "Actors"."Surname" = 'Berry';

-- d results:
--
--  count 
-- -------
--      1
-- (1 row)

-- e. min. max, and avg budget for each genre of movie

select "Genres", MAX("Budget"), AVG("Budget"), MIN("Budget") from "Movies"
join "Has Genres" using ("MovieID")
join "Genres" using ("GenreID") 
group by "Genres";

-- e results:
--
--      Genres     |    max    |          avg           |    min    
-- ----------------+-----------+------------------------+-----------
--  (1,Action,)    | 185000000 | 121000000.000000000000 |  18000000
--  (2,Adventure,) |  94000000 |  68333333.333333333333 |  18000000
--  (4,Crime,)     | 185000000 |  47400000.000000000000 |   6000000
--  (5,Drama,)     | 185000000 |  50000000.000000000000 |   6000000
--  (7,Fantasy,)   |  94000000 |  68333333.333333333333 |  18000000
--  (9,Mystery,)   | 160000000 | 160000000.000000000000 | 160000000
--  (10,Sci-Fi,)   | 160000000 | 160000000.000000000000 | 160000000
-- (7 rows)

-- f. average rating where director born in new york city or had blue eyes

select avg("Rating") from "Movies"
join "Movie Directors" using ("MovieID")
join "Directors" using ("DirectorID")
join "Cities" using ("CityID")
where "Name" = 'New York City' or "Eye_colour" = 'Blue';

-- f results:
--
--   avg  
-- -------
--  8.875
-- (1 row)

-- g. all movies with actors born in 2 different countries

select "Movie_title" from "Movies"
join "Movie Actors" using ("MovieID")
join "Actors" using ("ActorID")
join "Cities" using ("CityID")
join "States" using ("StateID")
join "Countries" using ("CountryID")
where "CountryID" in (select "CountryID" from "Countries"
	join "States" using ("CountryID")
	join "Cities" using ("StateID")
	join "Actors" using ("CityID") 
	GROUP BY "CountryID" HAVING COUNT(*) > 1);

-- g results:
--
--                   Movie_title                   
-- ------------------------------------------------
--  Fight Club
--  The Godfather Part II
--  Pulp Fiction
--  Star Wars: Episode V - The Empire Strikes Back
-- (4 rows)

-- h. finds the average rating for each ganre

select "Name", avg("Rating") as avg_rating from "Movies" 
join "Has Genres" using ("MovieID")
join "Genres" using ("GenreID")
join "Movie Actors" using ("MovieID")
join "Actors" using ("ActorID")
group by "Genres"."Name";

-- h results:
--
--    Name    |    avg_rating    
-- -----------+------------------
--  Crime     | 8.96666666666667
--  Sci-Fi    |              8.7
--  Drama     | 8.94285714285714
--  Fantasy   |              8.7
--  Adventure |              8.7
--  Action    |              8.8
--  Mystery   |              8.7
-- (7 rows)


 