# Phase 6 — Seed Data and DML Script

**Course:** CSC 273 Database Systems  
**Project:** Basketball 3v3 Tournament Database  
**Student:** Enmanuel Cepeda

I added fictional basketball teams, players, tournament dates, game scores, and player statistics so my Phase 5 queries can return useful results. The rows are inserted in order so that foreign keys always point to records that already exist. I also included two transactions: a `COMMIT` that saves a complete game result and a `ROLLBACK` that undoes a mistaken score correction.

## How to run

1. Back up anything important. The Phase 4 `schema/schema.sql` begins with `DROP DATABASE IF EXISTS Basketball3v3DB` and **deletes the existing database**. Only run it when you intentionally want a fresh empty copy.
2. In MySQL Workbench, run `schema/schema.sql` once against a fresh database.
3. Run `data/seed.sql` once. It starts with `USE Basketball3v3DB;`.
4. Review the final verification results: 7 coaches, 6 teams, 20 players, 6 tournaments, 6 games, 12 game-team rows, and 36 player-game statistics rows.
5. Run the Phase 5 `queries/queries.sql` to see the sample data in reports.

## What the transactions demonstrate

- **COMMIT:** inserts Game 6, its two team scores, and six player statistics as a single complete game-result operation. A transaction is useful here because partial completion would produce an inconsistent report.
- **ROLLBACK:** briefly changes Game 6's team score and one player's points to incorrect values and then reverses both updates. The script selects the restored values to show that the mistake was not saved.

## Edge cases

- An unassigned coach and a team without players show parent records without children.
- An upcoming tournament has no games and a `NULL` MVP.
- A player records zero points in one game.
- Events span several months, and contact information includes optional `NULL` values.
- The existing Phase 4 schema has **no status column** to mark an actual row inactive. No columns were invented or schema changes made here.

## Submission

Upload `data/seed.sql` into the `data` folder of the existing GitHub repository. Do not replace `schema/schema.sql` or the files from Phase 5. Paste the GitHub repository URL into the Canvas text-entry submission.

**Note:** I checked the SQL against the Phase 4 column names and validated its data relations using a local compatibility test, but it still needs to be executed in your own MySQL 8.0 environment to confirm a clean run for the assignment.
