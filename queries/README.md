# Phase 5A — JOIN Queries

**Project:** Basketball 3v3 Tournament Database  
**Course:** CSC 273 — Database Systems  
**Student:** Enmanuel Cepeda

This folder contains five SQL queries for my basketball 3v3 tournament database. Each query uses a JOIN to answer a question that helps organize teams, games, or player results.

## Query 1 — Players, teams, and coaches

This query supports my goal of keeping player rosters and coaches organized. It joins `Players` to `Teams` using `TeamID` and then `Teams` to `Coaches` using `CoachID`, since the information is stored in three different tables. It helps me see which players belong to each team and who their coach is.

## Query 2 — Game schedule and location

This query helps organize the schedule for the tournament. It joins `Games` to `Tournaments` using `TournamentID` because the game date and time are in one table, while the venue and location are in another. It shows where and when games are scheduled so players and organizers can plan ahead.

## Query 3 — Number of players on each team

This query helps me check how many players are registered for each team. It uses a `LEFT JOIN` from `Teams` to `Players` through `TeamID` so teams still appear even when they have no players yet. This makes it easier to find teams that still need players before the tournament starts.

## Query 4 — Game scores by team

This query supports my goal of tracking game results. It connects `GameTeams` to `Games` through `GameID`, to `Teams` through `TeamID`, and then `Games` to `Tournaments` through `TournamentID`. It shows each team's recorded score for a game along with the game date and location, so I can review results and compare teams in the same game.

## Query 5 — Player scoring leaders

This query helps track player performance across games. It joins `PlayerGameStats` to `Players` through `PlayerID` and `Players` to `Teams` through `TeamID`, then adds up each player's points, rebounds, and assists. It shows which players have scored the most points and can help with reviewing player performance during the tournament.

## How to run the queries

1. Open MySQL Workbench and connect to your MySQL server.
2. Make sure the Phase 4 `schema/schema.sql` has already created `Basketball3v3DB` and its tables.
3. Make sure your database has sample or real records. If the tables are empty, some queries will return no rows.
4. Open `queries.sql` and run the queries. The script begins with `USE Basketball3v3DB;`.

## JOIN requirements checklist

- [x] Five `SELECT` queries with at least one JOIN each
- [x] At least two queries use `INNER JOIN` (Q1, Q2, Q4, Q5)
- [x] At least one query uses `LEFT JOIN` (Q3)
- [x] At least one query joins three or more tables (Q1, Q4, Q5)
- [x] Every query has a plain-English SQL comment describing its question
- [x] Every query supports a practical question from the tournament project
