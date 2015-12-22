-- a. returns directors first name and last name if they were born in france

select "First_name", "Surname", "Countries"."Name" as Country from "Directors" 
join "Cities" using ("CityID")
join "States" using ("StateID")
join "Countries" using ("CountryID")
where "Countries"."Name" = 'France';

-- a results: 
--  First_name  | Surname | country 
-- -------------+---------+---------
--  Christopher | Nolan   | France
-- (1 row)

-- b. lists all movies directed by Peter Jackson

select "Movie_title" from "Movies"
join "Movie Directors" using ("MovieID")
join "Directors" using ("DirectorID")
where "First_name" = 'Peter' and "Surname" = 'Jackson';

-- b results:
--                   Movie_title                  
-- -----------------------------------------------
--  The Lord of the Rings: Fellowship of the Ring
--  The Lord of the Rings: The Two Towers
--  Inception
-- (3 rows)

-- c. lists all actors who were in movies that had a budget over $15,000,000
--    and lists budget in other currencies

select "First_name", "Surname", "Budget" as USD, "Budget"*1.33 as CAD,
"Budget"*122.74 as jpy, "Budget"*65.56 as rub, "Budget"*0.94 as eur,
"Budget"*1.02 as chf  
from "Actors"
join "Movie Actors" using ("ActorID")
join "Movies" using ("MovieID")
where "Budget" > 15000000;

-- c results: 
--
--  First_name |  Surname   |    usd    |     cad      |      jpy       |      rub       |     eur      |     chf      
-- ------------+------------+-----------+--------------+----------------+----------------+--------------+--------------
--  Scarlett   | Johansson  | 160000000 | 212800000.00 | 19638400000.00 | 10489600000.00 | 150400000.00 | 163200000.00
--  Angelina   | Jolie      |  63000000 |  83790000.00 |  7732620000.00 |  4130280000.00 |  59220000.00 |  64260000.00
--  Melissa    | McCarthy   | 185000000 | 246050000.00 | 22706900000.00 | 12128600000.00 | 173900000.00 | 188700000.00
--  Robert     | Downey Jr. |  25000000 |  33250000.00 |  3068500000.00 |  1639000000.00 |  23500000.00 |  25500000.00
--  Chris      | Hemsworth  | 185000000 | 246050000.00 | 22706900000.00 | 12128600000.00 | 173900000.00 | 188700000.00
--  Chris      | Pratt      |  94000000 | 125020000.00 | 11537560000.00 |  6162640000.00 |  88360000.00 |  95880000.00
--  Tom        | Cruise     |  18000000 |  23940000.00 |  2209320000.00 |  1180080000.00 |  16920000.00 |  18360000.00
-- (7 rows)


-- d. lists all directors whose names begin with 'W' or 'J'

select * from "Directors"
where "Surname" LIKE 'W%' OR "Surname" LIKE 'J%';

-- d results:
--
--  DirectorID | CityID | First_name | Year_of_birth |  Surname  | Eye_colour 
-- ------------+--------+------------+---------------+-----------+------------
--           5 |      2 | Lana       |          1965 | Wachowski | Blue
--           7 |     11 | Peter      |          1961 | Jackson   | Blue
-- (2 rows)


-- e. lists all Crime movies with actors older then 35 years

select "Movie_title" from "Movies" 
join "Has Genres" using ("MovieID")
join "Genres" using ("GenreID")
join "Movie Actors" using ("MovieID")
join "Actors" using ("ActorID")
where (2015-DATE_PART('YEAR', "Date_of_birth") > 35) and "Genres"."Name" = 'Crime';

-- e results:
--
--        Movie_title        
-- --------------------------
--  Pulp Fiction
--  The Dark Knight
--  The Godfather Part II
--  The Shawshank Redemption
-- (4 rows)

-- f. lists all actors that have blue eyes in ascending order

select * from "Actors"
where "Eye_colour" = 'Blue'
Group by "ActorID";

--f results:
--
--  ActorID | CityID | First_name | Date_of_birth |  Surname   | Eye_colour 
-- ---------+--------+------------+---------------+------------+------------
--        6 |      4 | Robert     | 1965-04-04    | Downey Jr. | Blue
--        3 |      9 | Angelina   | 1975-06-04    | Jolie      | Blue
-- (2 rows)

