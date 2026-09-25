# Phase 2 - Field List & Table Structures

## Basketball 3v3 Tournament Database

For this phase, I organized my fields into tables. I tried to keep each table focused on one single subject.

## Players

| Field | Type | Length | Null? | Required? | Default | Notes / Constraints |
|---|---|---:|---|---|---|---|
| Player_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | AUTO_INCREMENT | Unique positive ID for each player |
| Player_First_Name | VARCHAR | 50 | NOT NULL | Yes | - | Player's first name |
| Player_Last_Name | VARCHAR | 50 | NOT NULL | Yes | - | Player's last name |
| Player_Date_of_Birth | DATE | - | NOT NULL | Yes | - | Must be a valid past date |
| Team_ID | INT UNSIGNED | - | NOT NULL | Yes | - | Positive whole number |

---

## Teams

| Field | Type | Length | Null? | Required? | Default | Notes / Constraints |
|---|---|---:|---|---|---|---|
| Team_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | AUTO_INCREMENT | Unique positive ID for each team |
| Team_Name (AK) | VARCHAR | 100 | NOT NULL | Yes | - | Must be UNIQUE |
| Coach_ID | INT UNSIGNED | - | NULL | No | NULL | Positive whole number if a coach is assigned |

---

## Coaches

| Field | Type | Length | Null? | Required? | Default | Notes / Constraints |
|---|---|---:|---|---|---|---|
| Coach_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | AUTO_INCREMENT | Unique positive ID for each coach |
| Coach_First_Name | VARCHAR | 50 | NOT NULL | Yes | - | Coach's first name |
| Coach_Last_Name | VARCHAR | 50 | NOT NULL | Yes | - | Coach's last name |
| Coach_Phone_Number | VARCHAR | 20 | NULL | No | NULL | Stores phone number as text |
| Coach_Email (AK) | VARCHAR | 254 | NOT NULL | Yes | - | Must be UNIQUE |

---

## Tournaments

| Field | Type | Length | Null? | Required? | Default | Notes / Constraints |
|---|---|---:|---|---|---|---|
| Tournament_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | AUTO_INCREMENT | Unique positive ID for each tournament |
| Tournament_Date | DATE | - | NOT NULL | Yes | - | Must be a valid date |
| Venue_Name | VARCHAR | 100 | NOT NULL | Yes | - | Name of the tournament location |
| City | VARCHAR | 100 | NOT NULL | Yes | - | City where the tournament takes place |
| State | VARCHAR | 50 | NOT NULL | Yes | - | State where the tournament takes place |
| MVP_Player_ID | INT UNSIGNED | - | NULL | No | NULL | Can be empty until an MVP is selected |

---

## Games

| Field | Type | Length | Null? | Required? | Default | Notes / Constraints |
|---|---|---:|---|---|---|---|
| Game_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | AUTO_INCREMENT | Unique positive ID for each game |
| Tournament_ID | INT UNSIGNED | - | NOT NULL | Yes | - | Positive whole number |
| Game_Date | DATE | - | NOT NULL | Yes | - | Must be a valid date |
| Game_Time | TIME | - | NOT NULL | Yes | - | Must be a valid time |

---

## GameTeams

| Field | Type | Length | Null? | Required? | Default | Notes / Constraints |
|---|---|---:|---|---|---|---|
| Game_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | - | Part of the combined primary key |
| Team_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | - | Part of the combined primary key |
| Team_Score | INT UNSIGNED | - | NULL | No | NULL | Must be 0 or greater |

**Primary Key:** Game_ID + Team_ID

---

## PlayerGameStats

| Field | Type | Length | Null? | Required? | Default | Notes / Constraints |
|---|---|---:|---|---|---|---|
| Game_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | - | Part of the combined primary key |
| Player_ID (PK) | INT UNSIGNED | - | NOT NULL | Yes | - | Part of the combined primary key |
| Player_Points | INT UNSIGNED | - | NOT NULL | Yes | 0 | Must be 0 or greater |
| Player_Rebounds | INT UNSIGNED | - | NOT NULL | Yes | 0 | Must be 0 or greater |
| Player_Assists | INT UNSIGNED | - | NOT NULL | Yes | 0 | Must be 0 or greater |
| Player_Steals | INT UNSIGNED | - | NOT NULL | Yes | 0 | Must be 0 or greater |

**Primary Key:** Game_ID + Player_ID

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


