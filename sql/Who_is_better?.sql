-- Creamos la tabla player_name
CREATE TABLE player_name (
    player VARCHAR(50) PRIMARY KEY
);
-- Inserto los nombres de los jugadores
INSERT INTO player_name (player)
VALUES ('Michael Jordan'), ('Kobe Bryant'), ('Lebron James');

ALTER TABLE player_name
ADD COLUMN player_text TEXT;

-- Copiar datos de la columna original a la nueva columna
UPDATE player_name
SET player_text = player;

-- Elimino la columna original
ALTER TABLE player_name
DROP COLUMN player;

-- Renombro la nueva columna
ALTER TABLE player_name
RENAME COLUMN player_text TO player;

ALTER TABLE totals_stats
MODIFY COLUMN Player VARCHAR(255);

CREATE INDEX idx_player_name_player ON player_name(player);

ALTER TABLE player_name
MODIFY COLUMN player VARCHAR(255);

CREATE INDEX idx_player_name_player ON player_name(player);

INSERT INTO player_name (player)
VALUES ('Michael Jordan'), ('Kobe Bryant'), ('Lebron James');

ALTER TABLE totals_stats
ADD CONSTRAINT fk_player_name
FOREIGN KEY (Player) REFERENCES player_name(player);

DELETE FROM player_name WHERE Player IS NULL;

-- CONSULTAS

-- Primera consulta: Media de puntos anotados por cada jugador en la temporada regular y los playoffs en toda su carrera:
SELECT Player, Total_PTS,
    CASE 
        WHEN RANK() OVER (ORDER BY Total_PTS DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Total_PTS DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Total_PTS DESC) = 3 THEN 1
    END AS Puntos
FROM (
    SELECT Player, ROUND(AVG(PTS), 2) AS Total_PTS
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Total_PTS DESC;


-- Segunda consulta: Porcentaje de tiros de campo anotados de cada jugador en la temporada regular y los playoffs en toda su carrera:

SELECT Player, FG_Percentage,
    CASE 
        WHEN RANK() OVER (ORDER BY FG_Percentage DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY FG_Percentage DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY FG_Percentage DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, ROUND(AVG(`FG%`)*100, 2) AS FG_Percentage 
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant') 
    GROUP BY Player
) AS player_stats
ORDER BY FG_Percentage DESC;


-- Tercera consulta: Porcentaje de tiros de 3 puntos de cada jugador en la temporada regular y los playoffs enn toda su carrera:
SELECT Player, Three_Point_Percentage,
    CASE 
        WHEN RANK() OVER (ORDER BY Three_Point_Percentage DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Three_Point_Percentage DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Three_Point_Percentage DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, ROUND(AVG(`3P%`)*100, 2) AS Three_Point_Percentage
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Three_Point_Percentage DESC;


-- Cuarta consulta: Media de asistencias por temporada de cada jugador en la temporada regular y los playoffs en toda su carrera:
SELECT Player, Avg_AST,
    CASE 
        WHEN RANK() OVER (ORDER BY Avg_AST DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Avg_AST DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Avg_AST DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, ROUND(AVG(AST), 2) AS Avg_AST
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Avg_AST DESC;


-- Quinta consulta: Promedio de robos por temporada de cada jugador en la temporada regular y playoff en toda su carrera:
SELECT Player, Avg_STL,
    CASE 
        WHEN RANK() OVER (ORDER BY Avg_STL DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Avg_STL DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Avg_STL DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, ROUND(AVG(STL), 2) AS Avg_STL
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Avg_STL DESC;


-- Sexta consulta: Promedio de rebote por temporada de cada jugador en la temporada regular y playoff en toda su carrera:
SELECT Player, Avg_TRB,
    CASE 
        WHEN RANK() OVER (ORDER BY Avg_TRB DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Avg_TRB DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Avg_TRB DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, ROUND(AVG(TRB), 2) AS Avg_TRB
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Avg_TRB DESC;


-- Septima consulta: Promedio de tapones por temporada de cada jugador en la temporada regular y playoff en toda su carrera:
SELECT Player, Avg_BLK,
    CASE 
        WHEN RANK() OVER (ORDER BY Avg_BLK DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Avg_BLK DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Avg_BLK DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, AVG(BLK) AS Avg_BLK
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Avg_BLK DESC;


-- Octava consulta: Promedio de balones perdidos por temporada de cada jugador en la temporada regular y playoff en toda su carrera:
SELECT Player, Avg_TOV,
    CASE 
        WHEN RANK() OVER (ORDER BY Avg_TOV ASC) = 1 THEN 1
        WHEN RANK() OVER (ORDER BY Avg_TOV ASC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Avg_TOV ASC) = 3 THEN 3
    END AS Points
FROM (
    SELECT Player, AVG(TOV) AS Avg_TOV
    FROM totals_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Avg_TOV DESC;

-- Novena consulta: Promedio del ratio de eficiencia cada jugador(PER) en la temporada regular y playoff en toda su carrera:

SELECT Player, Avg_PER,
    CASE 
        WHEN RANK() OVER (ORDER BY Avg_PER DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Avg_PER DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Avg_PER DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, ROUND(AVG(PER), 2) AS Avg_PER
    FROM advanced_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats
ORDER BY Avg_PER DESC;

-- Decima consulta:  Promedio de BPM (Box Plus-Minus) por partido en la temporada regular y los playoffs:
/* BPM: estadísticas acumuladas y porcentaje de tiempo jugado para estimar el impacto general de un jugador 
en el rendimiento de su equipo durante todo el tiempo que está en la cancha.*/

SELECT Player, Avg_BPM,
    CASE 
        WHEN RANK() OVER (ORDER BY Avg_BPM DESC) = 1 THEN 3
        WHEN RANK() OVER (ORDER BY Avg_BPM DESC) = 2 THEN 2
        WHEN RANK() OVER (ORDER BY Avg_BPM DESC) = 3 THEN 1
    END AS Points
FROM (
    SELECT Player, AVG(BPM) AS Avg_BPM
    FROM advanced_stats
    WHERE Player IN ('Michael Jordan', 'LeBron James', 'Kobe Bryant')
    GROUP BY Player
) AS player_stats;


-- Creo una tabla para guardar los resultados y mostrar un total de cada jugador contabilizando las 10 consultas:
CREATE TABLE tabla_puntos (
    Player VARCHAR(255),
    Points INT
);

-- Voy a introducir los puntos de cada consulta y poder obtener los totales
-- Primera consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 3), ('LeBron James', 2), ('Kobe Bryant', 1);

-- Segunda consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 2), ('LeBron James', 3), ('Kobe Bryant', 1);

-- Tercera consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 2), ('LeBron James', 3), ('Kobe Bryant', 1);

-- Cuarta consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 2), ('LeBron James', 3), ('Kobe Bryant', 1);

-- Quinta consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 3), ('LeBron James', 2), ('Kobe Bryant', 1);

-- Sexta consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 2), ('LeBron James', 3), ('Kobe Bryant', 1);

-- Septima consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 2), ('LeBron James', 3), ('Kobe Bryant', 1);

-- Octava consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 3), ('LeBron James', 1), ('Kobe Bryant', 2);

-- Novena consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 2), ('LeBron James', 3), ('Kobe Bryant', 1);

-- Decima consulta
INSERT INTO tabla_puntos (Player, Points) VALUES ('Michael Jordan', 2), ('LeBron James', 3), ('Kobe Bryant', 1);

-- Mostramos el resultado en tabla

SELECT player, sum(points) AS Total_points FROM tabla_puntos
GROUP BY player
ORDER BY Total_points desc;

/*Pues si miramos las estadísticas si que parece que Lebron James da miedo, quiza los demas no lo digan porque realmente
el miedo les paraliza y no son capaces de articular palabra, o simplemente que Shaquille es un bocazas!*/

------------------

-- OTRAS CONSULTAS

-- Promedio de minutos por juego (MP) de Lebron James en cada temporada separado por la Regular Season y por PlayOff:
SELECT Season, Player, RSorPO,
ROUND(AVG(MP) OVER(PARTITION BY Season), 2) AS AvgMPPerPosition
FROM per_game_stats
WHERE player = 'Lebron James'
ORDER BY player, season, RSorPO;

-- Promedio de minutos por juego (MP) de Michael Jordan en cada temporada separado por la Regular Season y por PlayOff:
SELECT Season, Player, RSorPO,
ROUND(AVG(MP) OVER(PARTITION BY Season), 2) AS AvgMPPerPosition
FROM per_game_stats
WHERE player = 'Michael Jordan'
ORDER BY player, season, RSorPO;

-- Promedio de minutos por juego (MP) de Kobe Bryant en cada temporada separado por la Regular Season y por PlayOff:
SELECT Season, Player, RSorPO,
ROUND(AVG(MP) OVER(PARTITION BY Season), 2) AS AvgMPPerPosition
FROM per_game_stats
WHERE player = 'Kobe Bryant'
ORDER BY player, season, RSorPO;






-- Encontrar el jugador con el mejor rendimiento en términos de Efficiency (GmSc) en un partido:
-- (GmSc) = (PTS + RB + AST + STL + BLK − FG Fallados − FT Fallados − PER)
SELECT ghs.Player, ghs.GmSc
FROM game_highs_stats AS ghs
JOIN (
    SELECT MAX(GmSc) AS max_GmSc
    FROM game_highs_stats
) AS max_ghs ON ghs.GmSc = max_ghs.max_GmSc


