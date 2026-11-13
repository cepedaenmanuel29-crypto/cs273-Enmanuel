-- CSC 273 - Database Systems | Phase 6 - Seed Data and DML
-- Project: Basketball 3v3 Tournament Database
-- Student: Enmanuel Cepeda
-- MySQL 8.0 | Compatible with Phase 4 schema/schema.sql
--
-- Run this script ONLY after creating a NEW, EMPTY database from schema/schema.sql.
-- The schema script drops and recreates the database, so do not run it on real data.
-- Do not run this seed script twice on the same database: primary keys are fixed.
-- All names and contact details below are fictional sample data.

USE Basketball3v3DB;

-- 1. COACHES: parent table first. Coach 7 has no assigned team yet.
-- Optional contact fields demonstrate NULL values; not every coach has all contacts.
INSERT INTO Coaches (CoachID, CoachFirstName, CoachLastName, CoachPhoneNumber, CoachEmail) VALUES
    (1, 'Marcus', 'Hill', '573-555-0110', 'marcus.hill@example.com'),
    (2, 'Denise', 'Walker', '314-555-0112', 'denise.walker@example.com'),
    (3, 'Andre', 'Rivera', NULL, 'andre.rivera@example.com'),
    (4, 'Samantha', 'Brooks', '636-555-0114', 'samantha.brooks@example.com'),
    (5, 'Carlos', 'Bennett', '573-555-0115', NULL),
    (6, 'Jasmine', 'Turner', '573-555-0116', 'jasmine.turner@example.com'),
    (7, 'Elena', 'Parker', NULL, 'elena.parker@example.com');

-- 2. TEAMS: each team points to an existing coach.
-- Northside Future (team 6) is registered but does not have players or games yet.
INSERT INTO Teams (TeamID, TeamName, CoachID) VALUES
    (1, 'Hannibal Hawks', 1),
    (2, 'River City Raptors', 2),
    (3, 'Missouri Storm', 3),
    (4, 'Gateway Ballers', 4),
    (5, 'Capitol Kings', 5),
    (6, 'Northside Future', 6);

-- 3. PLAYERS: 4-player rosters for five teams (3 active players and a substitute).
-- Teams can have no players while registration is still in progress.
INSERT INTO Players (PlayerID, PlayerFirstName, PlayerLastName, PlayerDateOfBirth, TeamID) VALUES
    (1, 'Jayden', 'Miles', '2004-02-14', 1),
    (2, 'Tyler', 'Johnson', '2005-06-03', 1),
    (3, 'Noah', 'Davis', '2003-12-20', 1),
    (4, 'Ethan', 'Lewis', '2005-09-07', 1),
    (5, 'Malik', 'Robinson', '2004-03-08', 2),
    (6, 'Brandon', 'Hall', '2003-11-19', 2),
    (7, 'Isaiah', 'Moore', '2005-01-29', 2),
    (8, 'Caleb', 'Young', '2004-08-11', 2),
    (9, 'Diego', 'Martinez', '2004-04-25', 3),
    (10, 'Jordan', 'White', '2005-07-30', 3),
    (11, 'Adrian', 'Lopez', '2003-10-16', 3),
    (12, 'Owen', 'Scott', '2005-05-02', 3),
    (13, 'Xavier', 'Brown', '2003-02-05', 4),
    (14, 'Cameron', 'King', '2004-09-18', 4),
    (15, 'Liam', 'Turner', '2005-12-09', 4),
    (16, 'Marcus', 'Green', '2004-06-17', 4),
    (17, 'Anthony', 'Cole', '2003-07-21', 5),
    (18, 'Samuel', 'Rivera', '2004-12-04', 5),
    (19, 'Elijah', 'Adams', '2005-03-26', 5),
    (20, 'Daniel', 'Baker', '2004-10-13', 5);

-- 4. TOURNAMENTS: events span February through December 2026.
-- Tournament 6 is upcoming, with NULL MVP and no games scheduled yet.
INSERT INTO Tournaments (TournamentID, TournamentDate, VenueName, City, State, MVPPlayerID) VALUES
    (1, '2026-02-14', 'HLGU Fieldhouse', 'Hannibal', 'Missouri', 1),
    (2, '2026-03-21', 'Riverfront Sports Center', 'St. Louis', 'Missouri', 13),
    (3, '2026-05-16', 'Central Community Gym', 'Columbia', 'Missouri', 1),
    (4, '2026-07-11', 'Capitol Recreation Center', 'Jefferson City', 'Missouri', 17),
    (5, '2026-09-12', 'Gateway Athletic Center', 'St. Louis', 'Missouri', 13),
    (6, '2026-12-05', 'HLGU Fieldhouse', 'Hannibal', 'Missouri', NULL);

-- 5. GAMES: five completed games are entered first.
-- A sixth completed game will be entered atomically in the COMMIT example below.
INSERT INTO Games (GameID, TournamentID, GameDate, GameTime) VALUES
    (1, 1, '2026-02-14', '10:00:00'),
    (2, 2, '2026-03-21', '13:30:00'),
    (3, 3, '2026-05-16', '11:15:00'),
    (4, 4, '2026-07-11', '15:00:00'),
    (5, 5, '2026-09-12', '12:00:00');

-- 6. GAME TEAMS: each of the five games has exactly two teams.
-- Team scores match the sum of their three players' recorded points.
INSERT INTO GameTeams (GameID, TeamID, TeamScore) VALUES
    (1, 1, 21),
    (1, 2, 17),
    (2, 3, 15),
    (2, 4, 21),
    (3, 1, 21),
    (3, 3, 19),
    (4, 2, 18),
    (4, 5, 21),
    (5, 4, 21),
    (5, 1, 17);

-- 7. PLAYER GAME STATS: 3 players from each team per completed game.
-- A player with zero points is a valid, realistic edge case (Game 2, Player 11).
INSERT INTO PlayerGameStats (GameID, PlayerID, PlayerPoints, PlayerRebounds, PlayerAssists, PlayerSteals) VALUES
    (1, 1, 8, 4, 2, 1),
    (1, 2, 7, 2, 3, 0),
    (1, 3, 6, 3, 1, 1),
    (1, 5, 7, 2, 1, 1),
    (1, 6, 5, 4, 2, 0),
    (1, 7, 5, 1, 1, 2),
    (2, 9, 5, 2, 1, 0),
    (2, 10, 10, 5, 2, 1),
    (2, 11, 0, 1, 0, 0),
    (2, 13, 8, 3, 2, 1),
    (2, 14, 7, 2, 3, 1),
    (2, 15, 6, 4, 1, 0),
    (3, 1, 10, 4, 3, 2),
    (3, 2, 6, 2, 2, 0),
    (3, 4, 5, 3, 1, 1),
    (3, 9, 9, 4, 1, 1),
    (3, 10, 6, 2, 3, 0),
    (3, 12, 4, 3, 2, 1),
    (4, 5, 7, 2, 4, 1),
    (4, 6, 6, 3, 2, 0),
    (4, 8, 5, 1, 3, 1),
    (4, 17, 8, 4, 2, 1),
    (4, 18, 7, 3, 1, 0),
    (4, 19, 6, 2, 2, 2),
    (5, 13, 8, 4, 2, 1),
    (5, 14, 8, 3, 3, 0),
    (5, 16, 5, 2, 1, 1),
    (5, 1, 7, 3, 2, 1),
    (5, 3, 6, 1, 2, 0),
    (5, 4, 4, 2, 1, 1);

-- ================================================================
-- TRANSACTION 1 - COMMIT: record another finished 3v3 game.
-- This is one real business operation: add the game, record the two
-- team scores, and record all six player performances.
-- WHY A TRANSACTION? If one INSERT fails partway through, the game
-- could otherwise be left with missing scores or player statistics.
-- Committing the full operation together avoids a partial result.
-- ================================================================
START TRANSACTION;
INSERT INTO Games (GameID, TournamentID, GameDate, GameTime) VALUES
    (6, 5, '2026-09-12', '16:30:00');
INSERT INTO GameTeams (GameID, TeamID, TeamScore) VALUES
    (6, 3, 21),
    (6, 5, 16);
INSERT INTO PlayerGameStats (GameID, PlayerID, PlayerPoints, PlayerRebounds, PlayerAssists, PlayerSteals) VALUES
    (6, 9, 8, 3, 2, 1),
    (6, 11, 7, 4, 1, 0),
    (6, 12, 6, 2, 3, 1),
    (6, 17, 6, 3, 1, 1),
    (6, 19, 5, 2, 2, 0),
    (6, 20, 5, 4, 1, 1);
COMMIT;

-- Confirm that Game 6 and its scores were saved by COMMIT.
SELECT GameID, TournamentID, GameDate, GameTime
FROM Games WHERE GameID = 6;
SELECT GameID, TeamID, TeamScore
FROM GameTeams WHERE GameID = 6 ORDER BY TeamID;

-- ================================================================
-- TRANSACTION 2 - ROLLBACK: undo an incorrect game score entry.
-- Imagine an organizer accidentally types 99 instead of 21 points.
-- The related player's points are also changed during the mistake.
-- We notice the problem before saving and ROLLBACK both updates.
-- WHY? Without rollback, inaccurate scores and player stats could
-- remain in the reports. The second SELECT shows values were undone.
-- ================================================================
START TRANSACTION;
UPDATE GameTeams
SET TeamScore = 99
WHERE GameID = 6 AND TeamID = 3;
UPDATE PlayerGameStats
SET PlayerPoints = 86
WHERE GameID = 6 AND PlayerID = 9;

-- Temporary wrong values (99 and 86) are visible inside the transaction.
SELECT TeamScore AS TemporaryWrongScore
FROM GameTeams WHERE GameID = 6 AND TeamID = 3;
SELECT PlayerPoints AS TemporaryWrongPlayerPoints
FROM PlayerGameStats WHERE GameID = 6 AND PlayerID = 9;

ROLLBACK;

-- Final values should still be 21 for the team and 8 for the player.
SELECT TeamScore AS RestoredTeamScore
FROM GameTeams WHERE GameID = 6 AND TeamID = 3;
SELECT PlayerPoints AS RestoredPlayerPoints
FROM PlayerGameStats WHERE GameID = 6 AND PlayerID = 9;

-- ================================================================
-- QUICK VERIFICATION - row totals for all seven tables.
-- Expected: 7 coaches, 6 teams, 20 players, 6 tournaments,
--           6 games, 12 game-team entries, 36 player-game stats.
-- Note: this schema has no active/inactive-status column; the edge
-- cases are an unassigned coach, an empty team, a future event,
-- an unselected MVP, and zero-point player performance.
-- ================================================================
SELECT 'Coaches' AS TableName, COUNT(*) AS RowCount FROM Coaches
UNION ALL SELECT 'Teams', COUNT(*) FROM Teams
UNION ALL SELECT 'Players', COUNT(*) FROM Players
UNION ALL SELECT 'Tournaments', COUNT(*) FROM Tournaments
UNION ALL SELECT 'Games', COUNT(*) FROM Games
UNION ALL SELECT 'GameTeams', COUNT(*) FROM GameTeams
UNION ALL SELECT 'PlayerGameStats', COUNT(*) FROM PlayerGameStats;
