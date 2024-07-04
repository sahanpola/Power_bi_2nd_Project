Create table alchole_dc
Like alchole ;
/*insert data to new table*/
INSERT alchole_dc
SELECT * FROM alchole;

SELECT * FROM alchole_dc;
/*Create new table to remove dublicate*/
CREATE TABLE `alchole_dc1` (
  `Product` text,
  `Brand` text,
  `Category` text,
  `Style` text,
  `Quantity` int DEFAULT NULL,
  `Quanity Units` text,
  `Volume(ml)` int DEFAULT NULL,
  `Pachage` text,
  `ABV` double DEFAULT NULL,
  `Units ofAlchole` double DEFAULT NULL,
  `Units(4dc_place)` double DEFAULT NULL,
  `Units_per(ml)` double DEFAULT NULL,
  `row_numbe` int 
);
/* Check the row number, if row number>1 its dublicate row */
INSERT INTO alchole_dc1
SELECT * , row_number()
OVER(PARTITION BY `Product`,`Brand`,`Category`,`Style`,`Quantity`,`Quanity Units`,`Volume(ml)`,`Pachage`,`ABV`,`Units ofAlchole`,`Units(4dc_place)`,`Units_per(ml)`)
 AS row_numbe FROM alchole_dc;
 -- Standarize data
 
 SELECT * FROM alchole_dc1 ;
 SELECT pachage, TRIM(pachage) FROM alchole_dc1;
 
 /*Trim all text data in the table*/
 UPDATE alchole_dc1
 SET Product = TRIM(Product),
 Brand = TRIM(Brand), Category = TRIM(Category),Style = TRIM(Style),
 Pachage =TRIM(Pachage);
 
 /*Check the incorrect text data in the table*/
 SELECT * FROM alchole_dc1;
 SELECT distinct Category FROM alchole_dc1;
 SELECT distinct Product FROM alchole_dc1;
 SELECT distinct Brand FROM alchole_dc1;
 SELECT distinct Pachage FROM alchole_dc1;
 
 SELECT distinct Quantity FROM alchole_dc1 WHERE `Quanity Units` = 'pint';
 
 /*Check the blank & null values*/
 
 SELECT * FROM alchole_dc1 WHERE Style ='' OR Style IS NULL;
 
 /* Identify some values in Style colum are empty, so then try to fill it*/
 
 UPDATE alchole_dc1 SET Style = NULL WHERE Style ='';
 
 SELECT * FROM alchole_dc1 t1 JOIN alchole_dc1 t2 
 ON t1.Product=t2.Product AND t1.Brand=t2.Brand AND t1.Category = t2.Category
 WHERE t1.Style IS NULL AND t2.Style IS NOT NULL;
 
 /*Updated  some missing data in Style colum*/
 UPDATE alchole_dc1 t1 JOIN alchole_dc1 t2
 ON t1.Product=t2.Product AND t1.Brand=t2.Brand AND t1.Category = t2.Category
 SET t1.Style=t2.Style
 WHERE t1.Style IS NULL AND t2.Style IS NOT NULL;
 
 SELECT * FROM alchole_dc1 WHERE ABV ='';
 SELECT * FROM alchole_dc1 WHERE `Volume(ml)` ='';
 
  SELECT * FROM alchole_dc1;
  SELECT * FROM alchole_dc1 WHERE `Units ofAlchole` ='';
  
  /*Delete Unnecessary Colum**/
  Alter table alchole_dc1
  DROP COLUMN Quantity,
  DROP COLUMN `Quanity Units`,
  DROP COLUMN `Units(4dc_place)`,
  DROP COLUMN `row_numbe`;
  
  
   SELECT * FROM alchole_dc1;
  
 
 ALTER TABLE alchole_dc1
 RENAME COLUMN Pachage to Package,
 RENAME COLUMN `Units ofAlchole` to `Units of Alchole`;
 
 
 