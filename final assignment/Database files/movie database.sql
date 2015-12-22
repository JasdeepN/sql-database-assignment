/*
Created: 9/29/2015
Modified: 11/1/2015
Model: PostgreSQL 9.4
Database: PostgreSQL 9.4
*/




-- Create tables section -------------------------------------------------

-- Table Directors

CREATE TABLE "Directors"(
 "DirectorID" Bigint NOT NULL,
 "CityID" Bigint NOT NULL,
 "First_name" Varchar NOT NULL,
 "Year_of_birth" Integer NOT NULL,
 "Surname" Varchar
)
;
COMMENT ON COLUMN "Directors"."First_name" IS 'the first name of the director '
;
COMMENT ON COLUMN "Directors"."Surname" IS 'surname of the director'
;

-- Create indexes for table Directors

CREATE INDEX "IX_born in" ON "Directors" ("CityID")
;

-- Add keys for table Directors

ALTER TABLE "Directors" ADD CONSTRAINT "Key1" PRIMARY KEY ("DirectorID")
;

ALTER TABLE "Directors" ADD CONSTRAINT "director_ID" UNIQUE ("DirectorID")
;

-- Table Actors

CREATE TABLE "Actors"(
 "ActorID" Bigint NOT NULL,
 "CityID" Bigint NOT NULL,
 "First_name" Varchar NOT NULL,
 "Date_of_birth" Date NOT NULL,
 "Surname" Varchar,
 "Eye_colour" Varchar
)
;

-- Create indexes for table Actors

CREATE INDEX "IX_Relationship4" ON "Actors" ("CityID")
;

-- Add keys for table Actors

ALTER TABLE "Actors" ADD CONSTRAINT "Key3" PRIMARY KEY ("ActorID")
;

ALTER TABLE "Actors" ADD CONSTRAINT "actor_id" UNIQUE ("ActorID")
;

-- Table Movies

CREATE TABLE "Movies"(
 "MovieID" Bigint NOT NULL,
 "Movie_title" Varchar NOT NULL,
 "Release_date" Date NOT NULL,
 "Budget" Integer NOT NULL,
 "Rating" Double precision,
 "Gross" Integer
)
;

-- Add keys for table Movies

ALTER TABLE "Movies" ADD CONSTRAINT "Key5" PRIMARY KEY ("MovieID")
;

-- Table Movie Directors

CREATE TABLE "Movie Directors"(
 "DirectorID" Bigint NOT NULL,
 "MovieID" Bigint NOT NULL
)
;

-- Add keys for table Movie Directors

ALTER TABLE "Movie Directors" ADD CONSTRAINT "Key9" PRIMARY KEY ("DirectorID","MovieID")
;

-- Table Movie Actors

CREATE TABLE "Movie Actors"(
 "ActorID" Bigint NOT NULL,
 "MovieID" Bigint NOT NULL
)
;

-- Add keys for table Movie Actors

ALTER TABLE "Movie Actors" ADD CONSTRAINT "Key10" PRIMARY KEY ("ActorID","MovieID")
;

-- Table Genres

CREATE TABLE "Genres"(
 "GenreID" Bigint NOT NULL,
 "Name" Varchar NOT NULL,
 "Description" Text
)
;

-- Add keys for table Genres

ALTER TABLE "Genres" ADD CONSTRAINT "Key17" PRIMARY KEY ("GenreID")
;

-- Table Has Genres

CREATE TABLE "Has Genres"(
 "MovieID" Bigint NOT NULL,
 "GenreID" Bigint NOT NULL
)
;

-- Add keys for table Has Genres

ALTER TABLE "Has Genres" ADD CONSTRAINT "Key18" PRIMARY KEY ("MovieID","GenreID")
;

-- Table Cities

CREATE TABLE "Cities"(
 "CityID" Bigint NOT NULL,
 "StateID" Bigint NOT NULL,
 "Name" Varchar NOT NULL
)
;

-- Create indexes for table Cities

CREATE INDEX "IX_Relationship2" ON "Cities" ("StateID")
;

-- Add keys for table Cities

ALTER TABLE "Cities" ADD CONSTRAINT "Key19" PRIMARY KEY ("CityID")
;

-- Table States

CREATE TABLE "States"(
 "StateID" Bigint NOT NULL,
 "CountryID" Bigint NOT NULL,
 "Name" Varchar NOT NULL
)
;

-- Create indexes for table States

CREATE INDEX "IX_Relationship1" ON "States" ("CountryID")
;

-- Add keys for table States

ALTER TABLE "States" ADD CONSTRAINT "Key20" PRIMARY KEY ("StateID")
;

-- Table Countries

CREATE TABLE "Countries"(
 "CountryID" Bigint NOT NULL,
 "Name" Varchar NOT NULL
)
;

-- Add keys for table Countries

ALTER TABLE "Countries" ADD CONSTRAINT "Key21" PRIMARY KEY ("CountryID")
;

-- Table Soundtracks

CREATE TABLE "Soundtracks"(
 "SoundtrackID" Bigint NOT NULL,
 "MovieID" Bigint NOT NULL,
 "Composer" Varchar
)
;

-- Create indexes for table Soundtracks

CREATE INDEX "Movie_Score" ON "Soundtracks" ("MovieID")
;

-- Add keys for table Soundtracks

ALTER TABLE "Soundtracks" ADD CONSTRAINT "Key22" PRIMARY KEY ("SoundtrackID")
;

-- Table Television Shows

CREATE TABLE "Television Shows"(
 "TVShowID" Bigint NOT NULL,
 "Name" Varchar NOT NULL,
 "Description" Text,
 "Release Year" Integer,
 "Rating" Double precision
)
;

-- Add keys for table Television Shows

ALTER TABLE "Television Shows" ADD CONSTRAINT "Key24" PRIMARY KEY ("TVShowID")
;

-- Table Television Actors

CREATE TABLE "Television Actors"(
 "ActorID" Bigint NOT NULL,
 "TVShowID" Bigint NOT NULL
)
;

-- Add keys for table Television Actors

ALTER TABLE "Television Actors" ADD CONSTRAINT "Key25" PRIMARY KEY ("ActorID","TVShowID")
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE "Movie Directors" ADD CONSTRAINT "directed" FOREIGN KEY ("DirectorID") REFERENCES "Directors" ("DirectorID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Movie Directors" ADD CONSTRAINT "directed by" FOREIGN KEY ("MovieID") REFERENCES "Movies" ("MovieID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Movie Actors" ADD CONSTRAINT "is in" FOREIGN KEY ("ActorID") REFERENCES "Actors" ("ActorID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Movie Actors" ADD CONSTRAINT "had actor" FOREIGN KEY ("MovieID") REFERENCES "Movies" ("MovieID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Has Genres" ADD CONSTRAINT "is genre" FOREIGN KEY ("MovieID") REFERENCES "Movies" ("MovieID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Has Genres" ADD CONSTRAINT "has" FOREIGN KEY ("GenreID") REFERENCES "Genres" ("GenreID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "States" ADD CONSTRAINT "have" FOREIGN KEY ("CountryID") REFERENCES "Countries" ("CountryID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Cities" ADD CONSTRAINT "contain" FOREIGN KEY ("StateID") REFERENCES "States" ("StateID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Directors" ADD CONSTRAINT "born in" FOREIGN KEY ("CityID") REFERENCES "Cities" ("CityID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Actors" ADD CONSTRAINT "born" FOREIGN KEY ("CityID") REFERENCES "Cities" ("CityID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Soundtracks" ADD CONSTRAINT "score" FOREIGN KEY ("MovieID") REFERENCES "Movies" ("MovieID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Television Actors" ADD CONSTRAINT "is in" FOREIGN KEY ("ActorID") REFERENCES "Actors" ("ActorID") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Television Actors" ADD CONSTRAINT "stars in" FOREIGN KEY ("TVShowID") REFERENCES "Television Shows" ("TVShowID") ON DELETE NO ACTION ON UPDATE NO ACTION
;