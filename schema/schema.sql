--EX 603 Assignment 2 - schema.sql
--Theme: Game Telemetry
--Author: Folagbade Adetoye
--Target: PostgreSQL 14+

--Reset. Reverse creation order

DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS match_participants CASCADE;
DROP TABLE IF EXISTS game_modes CASCADE;
DROP TABLE IF EXISTS match_modes CASCADE;

CREATE TABLE players(
    player_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE ,
    jersey_number INT NOT NULL,
    joined_at DATE NOT NULL,
    team_name VARCHAR(30) NOT NULL ,
    points INT,
    assists INT,
    CHECK ( joined_at >= '1970-01-01' AND joined_at <= '2090-01-01')
);
-- Players is first because it is a strong entity and can be referenced in other tables
CREATE TABLE game_modes(
    game_mode INT PRIMARY KEY ,
    game_type VARCHAR(30) NOT NULL ,
    length time,
    number_of_players INT
);
--game_modes is placed before matches because the type of match can be dependent the modes to choose the matches from
CREATE TABLE matches(
    match_id INT PRIMARY KEY,
    player_id INT,
    who_played VARCHAR(30) NOT NULL,
    match_type VARCHAR(30) NOT NULL,
    match_title VARCHAR NOT NULL,
    winner VARCHAR(30) NOT NULL ,
    match_date date,
    CHECK ( match_type IN ('home', 'away') ),
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);
--matches references players and needs to be placed after in proper order
CREATE TABLE match_participants(
    match_participant_id INT PRIMARY KEY,
    player_id INT NOT NULL ,
    match_id INT NOT NULL ,
    player_name VARCHAR(30) NOT NULL ,
    player_number INT NOT NULL ,
    played_time time,
    occurred_at date NOT NULL ,
    FOREIGN KEY(player_id) REFERENCES players(player_id) ON DELETE SET NULL
);
--match_participants has to exist after match because there are conditions where the table would have to reference information in the matches table
CREATE TABLE match_modes(
    match_id INT NOT NULL ,
    modes_id INT NOT NULL ,
    game_type VARCHAR(30),
    length time,
    number_of_players INT,
    PRIMARY KEY (match_id, modes_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (modes_id) REFERENCES game_modes(game_mode)
);
--match_modes is placed here because it needs to be after matches and game_modes because it is a junction table referencing the other tables
