# NFL Season

My project models 2026 NFL data that a fan might ask about in plain English. It includes conferences (AFC/NFC), teams, head coaches, team captains, and week 1–2 schedules. There are no scores.

## Query I thought it did well on

**Question**: Who coaches the team that Patrick Mahomes captains?

**Grok SQL Response**:
```sql
SELECT coaches.name FROM coaches JOIN captains ON coaches.team_id = captains.team_id WHERE captains.name = 'Patrick Mahomes';
```

**Friendly Response**: Andy Reid coaches Patrick Mahomes’s team.

This needed a join across captains, teams, and coaches. Zero-shot got the SQL right and the friendly answer named Andy Reid instead of dumping IDs.

## Question that it tripped up on

It did the SQL part almost right, but it did not answer the question the way a fan would want. I asked which teams play in week 1. I wanted the actual matchups (home vs away), like Patriots at Seahawks. It returned a flat list of 32 team names and then restated that list.

**Question**: Which teams play in week 1?

**Grok SQL Response**:
```sql
SELECT DISTINCT t.name
FROM teams t
JOIN games g ON t.team_id = g.home_team_id OR t.team_id = g.away_team_id
WHERE g.week = 1;
```

SQL Result is just team names: [('Patriots',), ('Seahawks',), ('Rams',), ... all 32 teams ...]

**Friendly response**: All 32 teams play in week 1: Patriots, Seahawks, Rams, 49ers, Bears, Panthers, Bengals, Buccaneers, Lions, Saints, Bills, Texans, Ravens, Colts, Browns, Jaguars, Steelers, Falcons, Jets, Titans, Chargers, Cardinals, Dolphins, Raiders, Packers, Vikings, Eagles, Commanders, Cowboys, Giants, Broncos, and Chiefs.

The SQL never selected home and away together, so the friendly answer had no opponents to talk about. I would have preferred something like, "In week 1 the Patriots play at the Seahawks, the 49ers play at the Rams, ..."

I used zero_shot for that run. I tried the same question again with single-domain double-shot, using an example of a successful coach join, to see if it would return matchups.

## Multi-shot

It still did not return home vs away. The SQL dropped `DISTINCT` and still only selected `t.name`. The friendly answer was the same giant list, without even saying that every team plays.

**Question (multi-shot)**: Which teams play in week 1?

**Grok SQL Response**:
```sql
SELECT t.name
FROM teams t
JOIN games g ON t.team_id = g.home_team_id OR t.team_id = g.away_team_id
WHERE g.week = 1;
```

SQL Result is still just team names: [('Patriots',), ('Seahawks',), ('Rams',), ... all 32 teams ...]

**Friendly response**: Here are the teams playing in week 1: Patriots, Seahawks, Rams, 49ers, Bears, Panthers, Bengals, Buccaneers, Lions, Saints, Bills, Texans, Ravens, Colts, Browns, Jaguars, Steelers, Falcons, Jets, Titans, Chargers, Cardinals, Dolphins, Raiders, Packers, Vikings, Eagles, Commanders, Cowboys, Giants, Broncos, and Chiefs.

The double-shot prompt did not fix this question. In both cases it queried teams that appear in week 1 games, but it never interpreted "which teams play" as "show the games." The extra example was about a coach name, so it did not teach the model to select home_team and away_team.

## Conclusion

For fairly simple joins, Grok does well at creating SQL queries. Questions like who coaches a team, who the captain is, or which AFC teams are home in week 2 came back correctly. That could be useful for looking up facts in a database.

A chat interface for non-engineers still has issues. If the SQL is slightly the wrong shape, the friendly answer can sound confident and still miss what you actually asked. More examples help when they match the question you care about. A random successful example did not help here.
