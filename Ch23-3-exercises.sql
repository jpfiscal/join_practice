/*Part I*/
/*Q1*/
SELECT *
FROM owners o FULL JOIN vehicles v ON o.id = v.owner_id

/*Q2*/
SELECT 
    o.first_name, 
    o.last_name,
    count(*) as "count"
FROM owners o RIGHT JOIN vehicles v ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
ORDER BY count

/*Q3*/
SELECT 
    o.first_name, 
    o.last_name,
    ROUND(CAST(AVG(v.price) as numeric),2) as "average_price",
    COUNT(*) as "count"
FROM owners o RIGHT JOIN vehicles v ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
HAVING AVG(v.price) > 10000 AND COUNT(*) > 1
ORDER BY o.first_name DESC

/*Part II (SQLZoo - Tutorial 6)*/
/*Q1*/
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

/*Q2*/
SELECT ga.id,stadium,team1,team2
FROM game ga INNER JOIN goal go ON ga.id = go.matchid
WHERE ga.id = 1012
LIMIT 1

/*Q3*/
SELECT player,teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = "GER"

/*Q4*/
SELECT team1, team2, player
FROM goal JOIN game on goal.matchid = game.id
WHERE player LIKE 'Mario%'

/*Q5*/
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON goal.teamid = eteam.id
 WHERE gtime<=10

/*Q6*/
SELECT mdate, teamname
FROM game JOIN eteam ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos'

/*Q7*/
SELECT player
FROM goal JOIN game on matchid=id
WHERE stadium = 'National Stadium, Warsaw'

/*Q8*/
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND goal.teamid <> 'GER'

/*Q9*/
SELECT teamname, count(*)
  FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
 ORDER BY teamname

/*Q10*/
SELECT stadium, COUNT(*)
FROM goal JOIN game on game.id = goal.matchid
GROUP BY stadium

/*Q11*/
SELECT matchid,mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate

/*Q12*/
SELECT matchid, mdate, COUNT(*)
FROM goal JOIN game ON goal.matchid=game.id
WHERE goal.teamid = 'GER'
GROUP BY matchid, mdate

/*Q13*/
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate,matchid,team1,team2

/*PART II (SQLZoo - Tutorial 7)*/
/*Q1*/
SELECT id, title
 FROM movie
 WHERE yr=1962
/*Q2*/
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'
/*Q3*/
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr
/*Q4*/
SELECT id
FROM actor
WHERE name = 'Glenn Close'
/*Q5*/
SELECT id
FROM movie
WHERE title = 'Casablanca'
/*Q6*/
SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid=11768
/*Q7*/
SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE movie.title = 'Alien'
/*Q8*/
SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'
/*Q9*/
SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND ord > 1
/*Q10*/
SELECT title, name
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1962 AND ord = 1
/*Q11*/
SELECT yr,COUNT(title) 
FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
/*Q12*/
SELECT title, name
FROM movie JOIN casting ON movie.id = casting.movieid AND ord=1
JOIN actor ON casting.actorid=actor.id
WHERE movie.id IN (
  SELECT movieid FROM casting
  WHERE actorid IN (
    SELECT id FROM actor
    WHERE name='Julie Andrews'))
/*Q13*/
SELECT name
FROM actor JOIN casting ON id=actorid
WHERE ord=1
GROUP BY name
HAVING COUNT(*) >=15
ORDER BY name
/*Q14*/
SELECT title, COUNT(*) as "cast_count"
FROM movie JOIN casting ON id=movieid
WHERE yr=1978
GROUP BY title
ORDER BY cast_count DESC, title
/*Q15*/
SELECT name
FROM actor JOIN casting ON actor.id=casting.actorid
WHERE casting.movieid in 
  (SELECT movie.id
  FROM movie JOIN casting ON movie.id=movieid
  JOIN actor ON actor.id=actorid
  WHERE name = 'Art Garfunkel')