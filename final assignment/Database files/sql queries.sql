INSERT INTO "Movies" VALUES 
(1, 'The Shawshank Redemption','10/14/1994', 25000000, 9.2, 28341469),
(2, 'The Godfather','3/24/1972', 6000000, 9.2, 131821952),
(3, 'The Godfather Part II','12/20/1974',13000000,9,57300000),
(4, 'The Dark Knight','7/18/2008',185000000,8.9,533316061),
(5, 'Pulp Fiction','10/14/1994',8000000,8.9,107928762),
(6, 'Fight Club','10/15/1995',	63000000, 8.8,37013395),
(7, 'The Lord of the Rings: Fellowship of the Ring','12/19/2001',93000000,8.8,315544750),
(8, 'Star Wars: Episode V - The Empire Strikes Back','6/20/1980',18000000,8.7,290158751),
(9, 'Inception','7/16/2010',160000000,8.7,292568851),
(10, 'The Lord of the Rings: The Two Towers','12/18/2002',94000000,8.7,342551365);

INSERT INTO "Genres" VALUES 
(1, 'Action'),
(2, 'Adventure'),
(3, 'Comedy'),
(4, 'Crime'),
(5, 'Drama'),
(6, 'Family'),
(7, 'Fantasy'),
(8, 'Horror'),
(9, 'Mystery'),
(10,'Sci-Fi'),
(11,'Thriller');

INSERT INTO "Has Genres" VALUES 
(1, 4), (1,5),
(2,4), (2,5),
(3,4), (3,5),
(4,1), (4,4), (4,5),
(5,4), (5,5),
(6,5),
(7,2), (7,7),
(8,1), (8,2), (8,7),
(9,1), (9,9), (9,10),
(10,2), (10, 7);

INSERT INTO "Countries" VALUES
(1, 'Canada'),
(2, 'United States of America'),
(3, 'South Africa'),
(4, 'Italy'),
(5, 'China'),
(6, 'Indonesia'),
(7, 'Japan'),
(8, 'France'),
(9, 'England'),
(10, 'Sweden'),
(11, 'New Zealand'),
(12, 'Australia');

INSERT INTO "States" VALUES 
(1, 1, 'Ontario'),
(2, 2, 'New York'),
(3, 2, 'California'),
(4, 3, 'Gauteng'),
(5, 4, 'Sicily'),
(6, 5, 'Guangdong'),
(7, 6, 'Bali'),
(8, 7, 'Kantō'),
(9, 8, 'Île-de-France'),
(10,9, 'Greater London'),
(11,10,'Södermanland'),
(12,11,'Wellington');

INSERT INTO "Cities" VALUES
(1, 1, 'Toronto'),
(2, 2, 'New York City'),
(3, 3, 'Los Angeles'),
(4, 4, 'Johannesburg'),
(5, 5, 'Palermo'),
(6, 6, 'Guangzhou'),
(7, 7, 'Bali'),
(8, 8, 'Tokyo'),
(9, 9, 'Paris'),
(10, 10, 'London'),
(11, 11, 'Stockholm'),
(12, 12, 'Wellington City');

INSERT INTO "Actors" VALUES 
(1, 5, 'Jenifer', 'aug 15 1990', 'Lawrence'),
(2, 8, 'Scarlett', 'nov 22 1984', 'Johansson'),
(3, 9, 'Angelina', 'june 4 1975', 'Jolie'),
(4, 10, 'Melissa', 'aug 29 1970', 'McCarthy'),
(5, 3, 'Halle', 'aug 14 1966', 'Berry'),
(6, 4, 'Robert', 'apr 4 1965', 'Downey Jr.'),
(7, 12, 'Chris', 'aug 11 1983', 'Hemsworth'),
(8, 9, 'Daniel', 'mar 2 1968', 'Criag'),
(9, 1, 'Chris', 'jun 21 1979', 'Pratt'),
(10, 2, 'Tom', 'july 3 1962', 'Cruise');

INSERT INTO "Movie Actors" VALUES
(1,5),
(2,9),
(3,6),
(4,4),
(5,3),
(6,1),
(7,4),
(8,5),
(9,10),
(10,8);

INSERT INTO "Directors" VALUES
(1, 2, 'David', 1946, 'Lynch'),
(2, 2, 'Martin', 1942, 'Scorsese'),
(3, 2, 'Quentin', 1963, 'Tarantino'),
(4, 2, 'Michael', 1954, 'Moore'),
(5, 2, 'Lana', 1965, 'Wachowski'),
(6, 8, 'Frank', 1959, 'Darabont'),
(7, 11, 'Peter', 1961, 'Jackson'),
(8, 9, 'Christopher', 1970, 'Nolan'),
(9, 2, 'David', 1962, 'Fincher'),
(10, 2, 'Irvin', 1923, 'Kershner');

INSERT INTO "Movie Directors" VALUES
(6, 1),
(8, 4),
(3, 5),
(7, 7),
(7, 10),
(1, 8),
(2, 2),
(9, 1),
(5, 7),
(7, 9);

INSERT INTO "Television Shows" VALUES
(1, 'Game of Thrones','Several noble families fight for control of the mythical land of Westeros.',2011, 9.4),
(2, 'Rick and Morty','An animated series that follows the exploits of a super scientist and his not so bright grandson.',2013, 9.3),
(3, 'Cosmos: A Spacetime Odyssey','A documentary series that explores how we discovered the laws of nature and found our coordinates in space and time.', 2014, 9.4),
(4, 'The Wire','Baltimore drug scene, seen through the eyes of drug dealers and law enforcement.', 2002, 9.3),
(5, 'Planet Earth','Emmy Award winning, 11-episodes, 5-years in the making, the most expensive nature documentary series ever commissioned by the BBC, and the first to be filmed in high definition.', 2006, 9.5),
(6, 'Band of Brothers','The story of Easy Company of the US Army 101st Airborne division and their mission in WWII Europe from Operation Overlord through V-J Day.', 2001, 9.6),
(7, 'Breaking Bad','A chemistry teacher diagnosed with terminal lung cancer teams up with his former student to cook and sell crystal meth.', 2008, 9.5),
(8, 'The Sopranos','New Jersey mob boss, Tony Soprano, deals with personal and professional issues in his home and business life.', 1999, 9.2),
(9, 'Sherlock ','A modern update finds the famous sleuth and his doctor partner solving crime in 21st century London.', 2010, 9.3),
(10, 'Cowboy Bebop','The futuristic misadventures and tragedies of an easygoing bounty hunter and his partners.', 1998, 9.0);

INSERT INTO "Television Actors" VALUES 
(5, 4),
(8, 1),
(10, 2),
(1, 1),
(6, 5),
(4, 9),
(3, 7),
(6, 9),
(10, 10),
(9, 6);

INSERT INTO "Soundtracks" VALUES
(1, 5, 'Hans Zimmer'),
(2, 9, 'John Williams'),
(3, 3, 'Howard Shore'),
(4, 7, 'Bernard Herrmann'),
(5, 1, 'Hans Zimmer'),
(6, 10, 'Jerry Goldsmith'),
(7, 2, 'James Horner'),
(8, 4, 'Danny Elfman'),
(9, 6, 'Elmer Bernstein'),
(10, 3, 'Ennio Morricone');

ALTER TABLE "Actors"
ADD "Eye_colour" varchar;

ALTER TABLE "Directors"
ADD "Eye_colour" varchar;

UPDATE "Actors"
SET "Eye_colour" = 'Blue'
WHERE "ActorID" = 3 OR "ActorID" = 6;

UPDATE "Actors"
SET "Eye_colour" = 'Green'
WHERE "ActorID" = 1 OR "ActorID" = 2;

UPDATE "Actors"
SET "Eye_colour" = 'Hazel'
WHERE "ActorID" = 9;

UPDATE "Directors"
SET "Eye_colour" = 'Blue'
WHERE "DirectorID" = 5 OR "DirectorID" = 7 OR "DirectorID" = 1;

UPDATE "Directors"
SET "Eye_colour" = 'Green'
WHERE "DirectorID" = 3;