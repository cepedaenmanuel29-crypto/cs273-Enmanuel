# Phase 2 - Field List & Table Structures

## Basketball 3v3 Tournament Database

For this phase, I organized my fields into tables. I tried to keep each table focused on one single subject.

## Players
This is a single subject table used to store information about each player.

| Field | Type | Null? | Default | Notes / Constraints |
|---|---|---|---|---|
| Player_ID (PK) | INT UNSIGNED | NOT NULL | AUTO_INCREMENT | Primary Key |
| Player_First_Name | VARCHAR(50) | NOT NULL | - | Player's first name |
| Player_Last_Name | VARCHAR(50) | NOT NULL | - | Player's last name |
| Player_Date_of_Birth | DATE | NOT NULL | - | Player's birth date |
| Team_ID (FK) | INT UNSIGNED | NOT NULL | - | Connects player to a team |

## Teams
This is a single subject table used to store information about each basketball team.

| Field | Type | Null? | Default | Notes / Constraints |
|---|---|---|---|---|
| Team_ID (PK) | INT UNSIGNED | NOT NULL | AUTO_INCREMENT | Primary Key |
| Team_Name | VARCHAR(100) | NOT NULL | - | Name of the team |
| Coach_ID (FK) | INT UNSIGNED | NOT NULL | - | Connects the team to a coach |

## Coaches
This is a single subject table used to store information about each coach.

| Field | Type | Null? | Default | Notes / Constraints |
|---|---|---|---|---|
| Coach_ID (PK) | INT UNSIGNED | NOT NULL | AUTO_INCREMENT | Primary Key |
| Coach_First_Name | VARCHAR(50) | NOT NULL | - | Coach's first name |
| Coach_Last_Name | VARCHAR(50) | NOT NULL | - | Coach's last name |
| Coach_Phone_Number | VARCHAR(20) | NULL | - | Coach's phone number |
| Coach_Email | VARCHAR(254) | NOT NULL | - | UNIQUE |

## Tournaments
This is a single subject table used to store information about each tournament.

| Field | Type | Null? | Default | Notes / Constraints |
|---|---|---|---|---|
| Tournament_ID (PK) | INT UNSIGNED | NOT NULL | AUTO_INCREMENT | Primary Key |
| Tournament_Date | DATE | NOT NULL | - | Date of the tournament |
| Venue_Name | VARCHAR(100) | NOT NULL | - | Name of the location |
| City | VARCHAR(100) | NOT NULL | - | City of the tournament |
| State | VARCHAR(50) | NOT NULL | - | State of the tournament |
| MVP_Player_ID (FK) | INT UNSIGNED | NULL | - | Player selected as MVP |

## Games
This is a single subject table used to store information about each game.

| Field | Type | Null? | Default | Notes / Constraints |
|---|---|---|---|---|
| Game_ID (PK) | INT UNSIGNED | NOT NULL | AUTO_INCREMENT | Primary Key |
| Tournament_ID (FK) | INT UNSIGNED | NOT NULL | - | Connects game to tournament |
| Game_Date | DATE | NOT NULL | - | Date of the game |
| Game_Time | TIME | NOT NULL | - | Starting time of the game |

## GameTeams
This table stores the teams that participate in each game and their scores.

| Field | Type | Null? | Default | Notes / Constraints |
|---|---|---|---|---|
| Game_ID (PK, FK) | INT UNSIGNED | NOT NULL | - | Connects to Games |
| Team_ID (PK, FK) | INT UNSIGNED | NOT NULL | - | Connects to Teams |
| Team_Score | INT UNSIGNED | NULL | - | Final score for the team |

## PlayerGameStats
This table stores each player's statistics for a specific game.

| Field | Type | Null? | Default | Notes / Constraints |
|---|---|---|---|---|
| Game_ID (PK, FK) | INT UNSIGNED | NOT NULL | - | Connects to Games |
| Player_ID (PK, FK) | INT UNSIGNED | NOT NULL | - | Connects to Players |
| Player_Points | INT UNSIGNED | NOT NULL | 0 | Points scored |
| Player_Rebounds | INT UNSIGNED | NOT NULL | 0 | Rebounds |
| Player_Assists | INT UNSIGNED | NOT NULL | 0 | Assists |
| Player_Steals | INT UNSIGNED | NOT NULL | 0 | Steals |

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


