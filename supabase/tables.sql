create table players (
    id serial primary key,
    name text not null,
    team_id int references teams(id) on delete set null,
    position text,    
    is_active boolean default true,
    unique (name)
);

create table teams (
    id serial primary key,
    abbreviation text not null unique
);

create table schedule (
    id serial primary key,
    player_id int not null references players(id) on delete cascade,
    nba_game_date date not null,
    fantasy_week_id int references fantasy_weeks(id) on delete cascade,
    season text not null,     
    unique (player_id, nba_game_date)
);

create table fantasy_weeks (
    id serial primary key,
    season text not null,         
    week_number int not null,  
    start_date date not null,
    end_date date not null,
    unique (season, week_number)
);

create table player_stats (
    id serial primary key,
    player_id int not null references players(id) on delete cascade,
    season text not null,                   
    stat_scope text not null check (stat_scope in ('current_season', 'last_2_weeks', 'last_season')),

    fgm numeric,
    fg_pct numeric,
    ftm numeric,
    ft_pct numeric,
    three_pm numeric,
    three_p_pct numeric,
    points numeric,
    def_reb numeric,
    off_reb numeric,
    rebounds numeric,
    assists numeric,
    steals numeric,
    blocks numeric,
    turnovers numeric,
    dd numeric,
    unique (player_id, season, stat_scope)
);

create table player_rankings (
    id serial primary key,
    player_id int not null references players(id) on delete cascade,
    season text not null,
    punt_string text not null,    -- e.g., 'none', 'punt_ft', 'punt_fg_to'
    total_z numeric not null,
    rank int not null,

    unique (player_id, season, punt_string)
);
