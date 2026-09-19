# Phase 2 - Field List & Table Structures

## Project
Basketball 3v3 Tournament Database

For this phase, I organized my field list into tables. I tried to keep each table about one single subject.

---

## Players

| Field Name | Data Type | Description |
|---|---|---|
| PlayerID | Number | Unique ID for each player. |
| PlayerFirstName | Text | Player's first name. |
| PlayerLastName | Text | Player's last name. |
| PlayerDateOfBirth | Date | Player's date of birth. |
| TeamID | Number | Shows what team the player belongs to. |

## Teams

| Field Name | Data Type | Description |
|---|---|---|
| TeamID | Number | Unique ID for each team. |
| TeamName | Text | Name of the team. |
| CoachID | Number | Shows who the coach of the team is. |

## Coaches

| Field Name | Data Type | Description |
|---|---|---|
| CoachID | Number | Unique ID for each coach. |
| CoachFirstName | Text | Coach's first name. |
| CoachLastName | Text | Coach's last name. |
| CoachPhoneNumber | Text | Coach's phone number. |
| CoachEmail | Text | Coach's email. |

## Tournaments

| Field Name | Data Type | Description |
|---|---|---|
| TournamentID | Number | Unique ID for each tournament. |
| TournamentDate | Date | Date of the tournament. |
| VenueName | Text | Name of the place where the tournament is played. |
| City | Text | City where the tournament is played. |
| State | Text | State where the tournament is played. |
| MVPPlayerID | Number | Player selected as MVP of the tournament. |

## Games

| Field Name | Data Type | Description |
|---|---|---|
| GameID | Number | Unique ID for each game. |
| TournamentID | Number | Shows what tournament the game belongs to. |
| GameDate | Date | Date of the game. |
| GameTime | Time | Time of the game. |

## GameTeams

| Field Name | Data Type | Description |
|---|---|---|
| GameID | Number | Shows the game. |
| TeamID | Number | Shows the team playing in the game. |
| TeamScore | Number | Final score for that team. |

## PlayerGameStats

| Field Name | Data Type | Description |
|---|---|---|
| GameID | Number | Shows the game. |
| PlayerID | Number | Shows the player. |
| PlayerPoints | Number | Points scored by the player. |
| PlayerRebounds | Number | Rebounds made by the player. |
| PlayerAssists | Number | Assists made by the player. |
| PlayerSteals | Number | Steals made by the player. |

---

# Normalization Decisions

## Multipart Field

Tournament Location was a multipart field because it had more than one piece of information inside one field.

I separated it into VenueName, City, and State. This makes the information easier to store and understand.

## Multivalued Field

The game originally had Team 1 and Team 2 in the same area. This means the game had multiple team values connected to it.

I created the GameTeams table so each team in a game can be stored separately with its score.

Player statistics can also happen many times because one player can play in many games. Because of this, I created the PlayerGameStats table.

## Single Subject

I separated Players, Teams, Coaches, Tournaments, Games, GameTeams, and PlayerGameStats because they are different subjects.

For example, player information belongs in the Players table, while game statistics belong in PlayerGameStats.

This helps each table stay focused on one single subject.

## Calculated Fields

Some fields do not need to be stored because they can be calculated later.

These calculated fields are:

- Winning Team
- Team Wins
- Team Losses
- Win Percentage
- Player Total Points
- Player Average Points

For example, Winning Team can be found by comparing the scores of both teams.

Player Total Points can be found by adding all the points a player scored in all games.

These calculated fields are not stored in the database schema.

---

# Table Descriptions

Players: This table stores information about each player.

Teams: This table stores information about each team.

Coaches: This table stores information about each coach.

Tournaments: This table stores information about each tournament.

Games: This table stores basic information about each game.

GameTeams: This table shows which teams played in each game and their scores.

PlayerGameStats: This table stores each player's statistics for each game.
