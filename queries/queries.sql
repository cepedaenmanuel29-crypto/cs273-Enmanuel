-- CSC 273 - Database Systems | Phase 5A - JOIN Queries
-- Project: Basketball 3v3 Tournament Database
-- Author: Enmanuel Cepeda
-- MySQL 8.0 | Based on the Phase 4 schema
-- Each query answers a question about the 3v3 tournament.

USE Basketball3v3DB;

-- Q1: Which players are on each team, and who coaches them?
SELECT
    t.TeamName,
    CONCAT(p.PlayerFirstName, ' ', p.PlayerLastName) AS PlayerName,
    CONCAT(c.CoachFirstName, ' ', c.CoachLastName) AS CoachName
FROM Players AS p
INNER JOIN Teams AS t ON p.TeamID = t.TeamID
INNER JOIN Coaches AS c ON t.CoachID = c.CoachID
ORDER BY t.TeamName, p.PlayerLastName, p.PlayerFirstName;

-- Q2: When and where will each tournament game take place?
SELECT
    g.GameID,
    g.GameDate,
    g.GameTime,
    tr.VenueName,
    tr.City,
    tr.State
FROM Games AS g
INNER JOIN Tournaments AS tr ON g.TournamentID = tr.TournamentID
ORDER BY g.GameDate, g.GameTime, g.GameID;

-- Q3: How many players does each team have, including teams with no players yet?
SELECT
    t.TeamName,
    COUNT(p.PlayerID) AS NumberOfPlayers
FROM Teams AS t
LEFT JOIN Players AS p ON t.TeamID = p.TeamID
GROUP BY t.TeamID, t.TeamName
ORDER BY t.TeamName;

-- Q4: Which teams played each game, and what score did each team record?
SELECT
    g.GameID,
    g.GameDate,
    tr.VenueName,
    t.TeamName,
    gt.TeamScore
FROM GameTeams AS gt
INNER JOIN Games AS g ON gt.GameID = g.GameID
INNER JOIN Teams AS t ON gt.TeamID = t.TeamID
INNER JOIN Tournaments AS tr ON g.TournamentID = tr.TournamentID
ORDER BY g.GameID, gt.TeamScore DESC, t.TeamName;

-- Q5: Which players have scored the most total points in recorded games?
SELECT
    p.PlayerID,
    CONCAT(p.PlayerFirstName, ' ', p.PlayerLastName) AS PlayerName,
    t.TeamName,
    COUNT(ps.GameID) AS GamesPlayed,
    SUM(ps.PlayerPoints) AS TotalPoints,
    SUM(ps.PlayerRebounds) AS TotalRebounds,
    SUM(ps.PlayerAssists) AS TotalAssists
FROM PlayerGameStats AS ps
INNER JOIN Players AS p ON ps.PlayerID = p.PlayerID
INNER JOIN Teams AS t ON p.TeamID = t.TeamID
GROUP BY p.PlayerID, p.PlayerFirstName, p.PlayerLastName, t.TeamID, t.TeamName
ORDER BY TotalPoints DESC, PlayerName;

-- PHASE 5B - AGGREGATE AND SUBQUERY QUERIES

-- Q6: How many games are scheduled for each tournament?
SELECT
    tr.TournamentID,
    tr.TournamentDate,
    tr.VenueName,
    COUNT(g.GameID) AS ScheduledGames
FROM Tournaments AS tr
LEFT JOIN Games AS g
    ON tr.TournamentID = g.TournamentID
GROUP BY tr.TournamentID, tr.TournamentDate, tr.VenueName
ORDER BY ScheduledGames DESC;

-- Q7: Which teams have scored the most points?
SELECT
    t.TeamName,
    COUNT(gt.GameID) AS GamesRecorded,
    COALESCE(SUM(gt.TeamScore), 0) AS TotalTeamPoints,
    COALESCE(ROUND(AVG(gt.TeamScore), 2), 0) AS AveragePointsPerGame
FROM Teams AS t
LEFT JOIN GameTeams AS gt
    ON t.TeamID = gt.TeamID
GROUP BY t.TeamID, t.TeamName
ORDER BY TotalTeamPoints DESC;

-- Q8: Which teams have at least three players?
SELECT
    t.TeamName,
    COUNT(p.PlayerID) AS RegisteredPlayers
FROM Teams AS t
LEFT JOIN Players AS p
    ON t.TeamID = p.TeamID
GROUP BY t.TeamID, t.TeamName
HAVING COUNT(p.PlayerID) >= 3
ORDER BY RegisteredPlayers DESC;

-- Q9: Which player performances scored above the average?
SELECT
    g.GameID,
    g.GameDate,
    CONCAT(p.PlayerFirstName, ' ', p.PlayerLastName) AS PlayerName,
    ps.PlayerPoints
FROM PlayerGameStats AS ps
INNER JOIN Players AS p
    ON ps.PlayerID = p.PlayerID
INNER JOIN Games AS g
    ON ps.GameID = g.GameID
WHERE ps.PlayerPoints > (
    SELECT AVG(PlayerPoints)
    FROM PlayerGameStats
)
ORDER BY ps.PlayerPoints DESC;

-- Q10: Which players have the highest average rebounds and assists?
SELECT
    CONCAT(p.PlayerFirstName, ' ', p.PlayerLastName) AS PlayerName,
    t.TeamName,
    COUNT(ps.GameID) AS GamesRecorded,
    ROUND(AVG(ps.PlayerRebounds), 2) AS AverageRebounds,
    ROUND(AVG(ps.PlayerAssists), 2) AS AverageAssists
FROM PlayerGameStats AS ps
INNER JOIN Players AS p
    ON ps.PlayerID = p.PlayerID
INNER JOIN Teams AS t
    ON p.TeamID = t.TeamID
GROUP BY p.PlayerID, p.PlayerFirstName, p.PlayerLastName,
         t.TeamID, t.TeamName
ORDER BY AverageRebounds DESC, AverageAssists DESC;

