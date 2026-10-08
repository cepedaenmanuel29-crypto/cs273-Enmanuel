# Phase 3 — ERD

## Project
Basketball 3v3 Tournament Database

This ERD shows how the tables from Phase 2 connect. I kept the same main tables and used primary keys, foreign keys, and linking tables to show the relationships clearly.

---

## What Each Table Represents

**Players** represents the players who take part in the 3v3 tournament. It stores basic player information and the team each player belongs to.

**Teams** represents the basketball teams. Each team has its own name and is connected to a coach.

**Coaches** represents the coaches. Coach contact information is stored here instead of repeating it in the Teams table.

**Tournaments** represents each 3v3 tournament. It stores the date, location, and the player selected as MVP when one has been chosen.

**Games** represents individual games played as part of a tournament. Each game belongs to one tournament.

**GameTeams** is a linking table between Games and Teams. It shows which teams played in each game and stores each team's score.

**PlayerGameStats** is a linking table between Games and Players. It stores the statistics a player recorded in one specific game.

---

## Relationship Design

### Coaches and Teams — 1:N
One coach can be connected to zero or many teams, but each team has one coach. The coach side is optional because a coach record can exist before a team is assigned. The team side is mandatory because a team needs a coach in this design.

If this were modeled as one-to-one, the same coach could not work with more than one team. That would make the design less flexible.

### Teams and Players — 1:N
One team can have zero or many players while the roster is being built, but each player belongs to one team. The team side is optional and the player side is mandatory.

If TeamID were stored multiple times inside one player field, the data would be harder to search and would not follow the normalized structure from Phase 2.

### Tournaments and Games — 1:N
One tournament can contain many games. A tournament can be created before its games are scheduled, so its participation can be optional at first. Every game must belong to exactly one tournament, so the game side is mandatory.

If the tournament information were repeated inside every game record, the same date and location information would be duplicated many times.

### Players and Tournaments (MVP) — 1:N
A player can be MVP in zero or many tournaments over time. A tournament can have zero or one MVP because the MVP may not be selected until the tournament is finished. MVPPlayerID is therefore an optional foreign key in Tournaments.

If MVP information were stored as plain text instead of a PlayerID, it would be easier to create spelling differences or point to a player who does not exist.

### Games and Teams — M:N resolved with GameTeams
A game has teams, and a team can play in many games. This is a many-to-many relationship, so I resolved it with the **GameTeams** linking table.

GameTeams contains GameID and TeamID as a composite primary key, and both fields are also foreign keys. TeamScore belongs in this table because the score belongs to one team in one specific game.

The business rule for a normal 3v3 game is that each game should have exactly two team rows in GameTeams. The linking table keeps the database normalized and avoids fields such as Team1ID and Team2ID.

### Games and Players — M:N resolved with PlayerGameStats
A game can have many players, and a player can appear in many games. This is another many-to-many relationship, so I resolved it with the **PlayerGameStats** linking table.

GameID and PlayerID form the composite primary key. The table also stores points, rebounds, assists, and steals because those values belong to one player in one game.

If these statistics were stored directly in Players, one player would need repeating stat fields for every game. If they were stored directly in Games, the game table would mix game information with player information.

---

## Hardest Relationship

The hardest relationship for me was **Games and Teams**. At first it seems like a game could just have Team 1 and Team 2 fields, but that would store the same kind of information in two separate columns. I resolved it by using GameTeams. Now each row connects one team to one game and also stores that team's score. This makes the relationship easier to understand and keeps the design normalized.

---

## Changes From Phase 2

I did not change the main field list from Phase 2. The biggest change was making the key roles and relationships more explicit in the ERD.

- PlayerID, TeamID, CoachID, TournamentID, and GameID are shown as primary keys in their main tables.
- TeamID in Players, CoachID in Teams, TournamentID in Games, and MVPPlayerID in Tournaments are shown as foreign keys.
- GameTeams uses GameID + TeamID as a composite primary key and linking pair.
- PlayerGameStats uses GameID + PlayerID as a composite primary key and linking pair.
- MVPPlayerID is optional because an MVP may not be selected until the tournament is complete.

The calculated fields from Phase 2 are still not stored in the ERD. Values such as winning team, win percentage, total points, and average points can be calculated later from the stored game and player statistics.
