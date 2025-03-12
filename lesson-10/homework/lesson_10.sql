use homework;
Drop table if exists shipments;
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
(30, 5), (31, 5), (32, 6), (33, 7);

select* from shipments

WITH Days AS (
    SELECT TOP 40 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS DayNumber
    FROM master.dbo.spt_values
),
ShipmentsFull AS (
    SELECT d.DayNumber AS N, COALESCE(s.Num, 0) AS Num
    FROM Days d
    LEFT JOIN Shipments s ON d.DayNumber = s.N
),
Ranked AS (
    SELECT Num, ROW_NUMBER() OVER (ORDER BY Num) AS rn,
                COUNT(*) OVER() AS total_rows
    FROM ShipmentsFull
)
SELECT AVG(CAST(Num AS FLOAT)) AS Median
FROM Ranked
WHERE rn IN (FLOOR((total_rows + 1) / 2), CEILING((total_rows + 1) / 2));