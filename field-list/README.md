# Phase 2 - Field List & Table Structures

## Basketball 3v3 Tournament Database

For this phase, I organized my fields into tables. I tried to keep each table focused on one single subject.

---

## Players

| Field Name | Data Type | Description |  |
|---|---|---|---|
| PlayerID | Integer | Unique ID for each player. |  |
| PlayerFirstName | Text | Player's first name. |  |
| PlayerLastName | Text | Player's last name. |  |
| PlayerDateOfBirth | Date | Player's date of birth. |  |
| TeamID | Integer | Shows what team the player belongs to. ||

## Teams

| Field Name | Data Type | Description | |
|---|---|---|---|
| TeamID | Integer | Unique ID for each team. ||
| TeamName | Text | Name of the team. | |
| CoachID | Integer | Shows who the coach of the team is. | |

## Coaches

| Field Name | Data Type | Description |  |
|---|---|---|---|
| CoachID | Integer | Unique ID for each coach. |  |
| CoachFirstName | Text | Coach's first name. |  |
| CoachLastName | Text | Coach's last name. |  |
| CoachPhoneNumber | Text | Coach's phone number. |  |
| CoachEmail | Text | Coach's email. |  |

## Tournaments

| Field Name | Data Type | Description |  |
|---|---|---|---|
| TournamentID | Integer | Unique ID for each tournament. |  |
| TournamentDate | Date | Date of the tournament. |  |
| VenueName | Text | Name of the place where the tournament is played. |  |
| City | Text | City where the tournament is played. |  |
| State | Text | State where the tournament is played. | |
| MVPPlayerID | Integer | Player selected as MVP. |  |

## Games

| Field Name | Data Type | Description | |
|---|---|---|---|
| GameID | Integer | Unique ID for each game. | |
| TournamentID | Integer | Shows what tournament the game belongs to. |  |
| GameDate | Date | Date of the game. |  |
| GameTime | Time | Starting time of the game. |  |

## GameTeams

| Field Name | Data Type | Description |  |
|---|---|---|---|
| GameID | Integer | Shows what game the team played in. |  |
| TeamID | Integer | Shows the team playing in the game. |  |
| TeamScore | Integer | Final score for that team. |  |

## PlayerGameStats

| Field Name | Data Type | Description |  |
|---|---|---|---|
| GameID | Integer | Shows what game the stats are from. |  |
| PlayerID | Integer | Shows what player the stats belong to. |  |
| PlayerPoints | Integer | Points scored by the player. |  |
| PlayerRebounds | Integer | Rebounds made by the player. |  |
| PlayerAssists | Integer | Assists made by the player. |  |
| PlayerSteals | Integer | Steals made by the player. |  |

---

# Normalization Decisions

## Multipart Field

Tournament Location was a multipart field because it had different pieces of information inside one field. I split it into VenueName, City, and State so each part can be stored separately.

## Multivalued Field

In my first field list, I had Team 1 ID and Team 2 ID for a game. This was multivalued information because one game has more than one team. I created the GameTeams table so each team can be connected to the game separately.

I also had Team 1 Score and Team 2 Score. I changed these into TeamScore in the GameTeams table, so the score belongs to the correct team and game.

## More Than One Subject

My original game information included the game, the teams, and their scores together. These are different subjects, so I kept the basic game information in Games and moved the teams and scores into GameTeams.

Player information and player game statistics are also different subjects. Player information stays in Players, while the statistics from each game are stored in PlayerGameStats.

## Calculated Fields

I had some calculated fields in Phase 1. I am not storing these fields in the database because they can be calculated from the other information when needed.

The calculated fields are:

- Winning Team
- Team Wins
- Team Losses
- Win Percentage
- Player Total Points
- Player Average Points

For example, Winning Team can be found by comparing the team scores. Player Total Points can be found by adding the points scored by the player in all games.

These calculated fields are excluded from the database schema.

---

# Changes From Phase 1

- Tournament Location was split into VenueName, City, and State.
- Team 1 ID and Team 2 ID were changed to TeamID in the GameTeams table.
- Team 1 Score and Team 2 Score were changed to TeamScore in the GameTeams table.
- Player Points, Rebounds, Assists, and Steals were moved to PlayerGameStats.
- GameID and PlayerID were added to PlayerGameStats to show which game and player the statistics belong to.
- TournamentID was added to Games to show which tournament each game belongs to.
- The calculated fields are documented but are not stored in the schema.

---

# Table Descriptions

Players: This table represents the players, and it is separate because player information is its own single subject.

Teams: This table represents the teams, and it is separate because team information is different from player and game information.

Coaches: This table represents the coaches, and it is separate because coach information is its own single subject.

Tournaments: This table represents each tournament, and it is separate because tournament information is different from game information.

Games: This table represents each game, and it is separate because the date and time describe the game itself.

GameTeams: This table represents the teams playing in each game and their scores, and it is separate because one game can have more than one team.

PlayerGameStats: This table represents a player's statistics in a game, and it is separate because a player can have different statistics in different games.


