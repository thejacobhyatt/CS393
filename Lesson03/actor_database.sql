-- Sakila Sample Database Schema
-- Version 1.5

-- Copyright (c) 2006, 2024, Oracle and/or its affiliates.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are
-- met:

-- * Redistributions of source code must retain the above copyright notice,
--   this list of conditions and the following disclaimer.
-- * Redistributions in binary form must reproduce the above copyright
--   notice, this list of conditions and the following disclaimer in the
--   documentation and/or other materials provided with the distribution.
-- * Neither the name of Oracle nor the names of its contributors may be used
--   to endorse or promote products derived from this software without
--   specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
-- IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
-- CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
-- EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
-- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


DROP DATABASE IF EXISTS actors;
CREATE DATABASE actors;
USE actors;

--
-- Table structure for table `actor`
--

CREATE TABLE Actor (
  actorId SMALLINT UNSIGNED NOT NULL,
  firstName VARCHAR(20) NOT NULL,
  lastName VARCHAR(45) NOT NULL
);


--
-- Table structure for table `category`
--

CREATE TABLE Category (
  categoryId TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(25) NOT NULL,
  numMovies INT NOT NULL,
  PRIMARY KEY  (categoryId)
);


--
-- Table structure for table `film`
--

CREATE TABLE Film (
  filmId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(128) NOT NULL,
  description TEXT DEFAULT NULL,
  releaseYear DATE DEFAULT NULL,
  rentalDuration TINYINT UNSIGNED NOT NULL DEFAULT 3,
  rentalRate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
  length SMALLINT UNSIGNED DEFAULT NULL,
  replacementCost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  specialFeatures SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  PRIMARY KEY (filmId)
);

--
-- Table structure for table `film_actor`
--

CREATE TABLE FilmActor (
  actorId TEXT NOT NULL,
  filmId TEXT NOT NULL,
  creditOrder INT UNSIGNED
);

--
-- Table structure for table `film_category`
--

CREATE TABLE FilmCategory (
  filmId SMALLINT UNSIGNED NOT NULL,
  categoryId TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (filmId, categoryId),
  FOREIGN KEY (filmId) REFERENCES Film (filmId) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (categoryId) REFERENCES Category (categoryId) ON DELETE RESTRICT ON UPDATE CASCADE
);