-- CSC 273 - Database Systems | Phase 4 - MySQL Schema
-- Project: Basketball 3v3 Tournament Database
-- Author: Enmanuel Cepeda
-- Built from the Phase 3 ERD: 7 tables and 8 foreign-key relationships.
-- MySQL 8.0 (CHECK constraints require MySQL 8.0.16 or later).
-- Running this script deletes and recreates this project's database.

DROP DATABASE IF EXISTS Basketball3v3DB;
CREATE DATABASE Basketball3v3DB
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE Basketball3v3DB;

-- 1. Coaches: One coach may manage several teams.
CREATE TABLE Coaches (
    CoachID INT NOT NULL AUTO_INCREMENT,
    CoachFirstName VARCHAR(50) NOT NULL,
    CoachLastName VARCHAR(50) NOT NULL,
    CoachPhoneNumber VARCHAR(20) NULL,
    CoachEmail VARCHAR(100) NULL,
    CONSTRAINT pk_coaches PRIMARY KEY (CoachID),
    CONSTRAINT uq_coaches_email UNIQUE (CoachEmail)
) ENGINE = InnoDB;

-- 2. Teams: Every team belongs to one coach.
CREATE TABLE Teams (
    TeamID INT NOT NULL AUTO_INCREMENT,
    TeamName VARCHAR(100) NOT NULL,
    CoachID INT NOT NULL,
    CONSTRAINT pk_teams PRIMARY KEY (TeamID),
    CONSTRAINT uq_teams_name UNIQUE (TeamName),
    CONSTRAINT fk_teams_coach FOREIGN KEY (CoachID)
        REFERENCES Coaches (CoachID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 3. Players: Every player is assigned to one team.
CREATE TABLE Players (
    PlayerID INT NOT NULL AUTO_INCREMENT,
    PlayerFirstName VARCHAR(50) NOT NULL,
    PlayerLastName VARCHAR(50) NOT NULL,
    PlayerDateOfBirth DATE NOT NULL,
    TeamID INT NOT NULL,
    CONSTRAINT pk_players PRIMARY KEY (PlayerID),
    CONSTRAINT fk_players_team FOREIGN KEY (TeamID)
        REFERENCES Teams (TeamID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 4. Tournaments: MVP can be NULL until a player is selected.
CREATE TABLE Tournaments (
    TournamentID INT NOT NULL AUTO_INCREMENT,
    TournamentDate DATE NOT NULL,
    VenueName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    MVPPlayerID INT NULL,
    CONSTRAINT pk_tournaments PRIMARY KEY (TournamentID),
    CONSTRAINT fk_tournaments_mvpplayer FOREIGN KEY (MVPPlayerID)
        REFERENCES Players (PlayerID)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE = InnoDB;

-- 5. Games: Every game takes place in one tournament.
CREATE TABLE Games (
    GameID INT NOT NULL AUTO_INCREMENT,
    TournamentID INT NOT NULL,
    GameDate DATE NOT NULL,
    GameTime TIME NOT NULL,
    CONSTRAINT pk_games PRIMARY KEY (GameID),
    CONSTRAINT fk_games_tournament FOREIGN KEY (TournamentID)
        REFERENCES Tournaments (TournamentID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 6. GameTeams: Connects teams and games; score is per team per game.
CREATE TABLE GameTeams (
    GameID INT NOT NULL,
    TeamID INT NOT NULL,
    TeamScore INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_gameteams PRIMARY KEY (GameID, TeamID),
    CONSTRAINT fk_gameteams_game FOREIGN KEY (GameID)
        REFERENCES Games (GameID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_gameteams_team FOREIGN KEY (TeamID)
        REFERENCES Teams (TeamID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_gameteams_score CHECK (TeamScore >= 0)
) ENGINE = InnoDB;

-- 7. PlayerGameStats: One row per player and game.
CREATE TABLE PlayerGameStats (
    GameID INT NOT NULL,
    PlayerID INT NOT NULL,
    PlayerPoints INT NOT NULL DEFAULT 0,
    PlayerRebounds INT NOT NULL DEFAULT 0,
    PlayerAssists INT NOT NULL DEFAULT 0,
    PlayerSteals INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_playergamestats PRIMARY KEY (GameID, PlayerID),
    CONSTRAINT fk_playergamestats_game FOREIGN KEY (GameID)
        REFERENCES Games (GameID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_playergamestats_player FOREIGN KEY (PlayerID)
        REFERENCES Players (PlayerID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_playergamestats_points CHECK (PlayerPoints >= 0),
    CONSTRAINT chk_playergamestats_rebounds CHECK (PlayerRebounds >= 0),
    CONSTRAINT chk_playergamestats_assists CHECK (PlayerAssists >= 0),
    CONSTRAINT chk_playergamestats_steals CHECK (PlayerSteals >= 0)
) ENGINE = InnoDB;

-- All seven tables are now created; no sample data is inserted.
-- A basketball game should ultimately have exactly two GameTeams rows,
-- and this cross-row business rule can be checked in the application layer.
