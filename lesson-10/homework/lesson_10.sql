use homework;

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


declare @topcount int;
select @topcount=ceiling(Cast(Max(N) as float)/2) --find the median of days to identify which row is appropriate by declare
from shipments;
select top(1) Num --by this selection we can get the median value of recors according to the descending numeration
from (
	select top(@topcount) N, NUM 
	from shipments --from this declaration we can find the records untill the median row
	order by N 
) as sub
order by N desc;