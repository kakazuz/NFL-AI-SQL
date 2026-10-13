create table conferences (
    conference_id integer primary key,
    name varchar(10) not null
);

create table teams (
    team_id integer primary key,
    name varchar(40) not null,
    city varchar(40) not null,
    conference_id integer not null,
    foreign key (conference_id) references conferences (conference_id)
);

create table coaches (
    coach_id integer primary key,
    name varchar(50) not null,
    team_id integer not null,
    foreign key (team_id) references teams (team_id)
);

create table captains (
    captain_id integer primary key,
    name varchar(50) not null,
    team_id integer not null,
    foreign key (team_id) references teams (team_id)
);

create table games (
    game_id integer primary key,
    week integer not null,
    home_team_id integer not null,
    away_team_id integer not null,
    foreign key (home_team_id) references teams (team_id),
    foreign key (away_team_id) references teams (team_id)
);
