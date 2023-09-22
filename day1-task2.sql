/* Day 1 Task 2: Schema Setup, Data Cleansing and Transformation
Create the schema for the data warehouse.
Cleanse and preprocess the data in the staging tables.
Handle missing values, data type conversions, and data quality checks.
Transform the data into a format suitable for fact and dimension Tables.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day1-task2.sql).
*/


/* CHANGE DATA VALUES FROM NA TO NULL OR OTHER TEXT 
WHERE APPROPRIATE FOR THE EXPECTED DATATYPE IN THE RAW DATA*/
UPDATE stage_irrigationdataraw 
SET irrigation_duration_min = NULL 
WHERE irrigation_duration_min LIKE '%NA%';

UPDATE stage_cropdataraw 
SET crop_yield = NULL 
WHERE crop_yield LIKE '%NA%';

UPDATE stage_cropdataraw 
SET growth_stage = 'Not Sure' 
WHERE growth_stage LIKE '%NA%';

UPDATE stage_soildataraw 
SET soil_comp = NULL 
WHERE soil_comp LIKE '%NA%';

UPDATE stage_soildataraw 
SET soil_moisture = NULL 
WHERE soil_moisture LIKE '%NA%';

UPDATE stage_soildataraw 
SET soil_ph = NULL 
WHERE soil_ph LIKE '%NA%';

UPDATE stage_soildataraw 
SET nitrogen_level = NULL 
WHERE nitrogen_level LIKE '%NA%';

UPDATE stage_soildataraw 
SET phosphorus_level = NULL 
WHERE phosphorus_level LIKE '%NA%';

UPDATE stage_soildataraw 
SET organic_matter = NULL 
WHERE organic_matter LIKE '%NA%';

UPDATE stage_weatherdataraw 
SET wind_speed = NULL 
WHERE wind_speed LIKE '%NA%';

UPDATE stage_weatherdataraw 
SET precipitation = NULL 
WHERE precipitation LIKE '%NA%';

UPDATE stage_sensordataraw 
SET temperature_f = NULL 
WHERE temperature_f LIKE '%NA%';

UPDATE stage_sensordataraw 
SET humidity = NULL 
WHERE humidity LIKE '%NA%';

UPDATE stage_sensordataraw 
SET soil_moisture = NULL 
WHERE soil_moisture LIKE '%NA%';

UPDATE stage_sensordataraw 
SET light_intensity = NULL 
WHERE light_intensity LIKE '%NA%';

/*REMOVE CHARACTERS FROM Sensor_Id VALUES IN RAW DATA*/
UPDATE stage_sensordataraw SET Sensor_Id = REPLACE(Sensor_Id, '"', '');
UPDATE stage_irrigationdataraw SET Sensor_Id = REPLACE(Sensor_Id, '*', '');
UPDATE stage_irrigationdataraw SET Sensor_Id = REPLACE(Sensor_Id, '_', '');
UPDATE stage_irrigationdataraw SET Sensor_Id = REPLACE(Sensor_Id, '#', '');
UPDATE stage_locationdataraw SET Sensor_Id = REPLACE(Sensor_Id, '*', '');
UPDATE stage_locationdataraw SET Sensor_Id = REPLACE(Sensor_Id, '_', '');
UPDATE stage_locationdataraw SET Sensor_Id = REPLACE(Sensor_Id, '#', '');


/* UPDATE MISSPELT WORD */
UPDATE stage_cropdataraw 
SET growth_stage = 'Flowering' 
WHERE growth_stage = 'Flowerring';
UPDATE stage_cropdataraw 
SET growth_stage = 'Vegetative' 
WHERE growth_stage = 'Vegatative';

UPDATE stage_cropdataraw
SET pest_issue = 'Aphids' 
WHERE pest_issue = 'Aphidds';
UPDATE stage_cropdataraw
SET pest_issue = 'Not Sure' 
WHERE pest_issue = 'NA';
UPDATE stage_irrigationdataraw 
SET irrigation_method = 'Drip' 
WHERE irrigation_method = 'Driip';
UPDATE stage_irrigationdataraw
SET water_source = 'River' 
WHERE water_source = 'Rivver';
UPDATE stage_irrigationdataraw 
SET water_source = 'Well' 
WHERE water_source = 'Wel';
UPDATE stage_irrigationdataraw 
SET irrigation_method = 'Sprinkler' 
WHERE irrigation_method = 'Spinkler';
UPDATE stage_pestdataraw 
SET pest_type = 'Aphids' 
WHERE pest_type = 'Aphiods';
UPDATE stage_pestdataraw 
SET pest_type = 'Slugs' 
WHERE pest_type = 'Slogs';

UPDATE stage_pestdataraw 
SET pest_severity = 'High' 
WHERE pest_severity = 'Hihg';

UPDATE stage_weatherdataraw 
SET weather_condition = 'Clear' 
WHERE weather_condition = 'Claar';

UPDATE stage_weatherdataraw 
SET weather_condition = 'Partly Cloudy' 
WHERE weather_condition = 'Party Cloudy';

/*UPDATE PESTDATARAW pest_description 
replace all occurence of wrong spelling*/
UPDATE stage_pestdataraw 
SET pest_description = REPLACE(pest_description, 'Slogs','Slugs');

UPDATE stage_pestdataraw 
SET pest_description = REPLACE(pest_description, 'Aphiods','Aphids');

UPDATE stage_pestdataraw 
SET pest_description = REPLACE(pest_description, 'deteced','detected');

UPDATE stage_pestdataraw 
SET pest_description = REPLACE(pest_description, 'riskkk','risk');

/* Change location to Farm */
UPDATE stage_locationdataraw SET Location_Name = REPLACE(Location_Name, 'Location', 'Farm');

/* DELETE NULL VALUES WHERE THERE IS NO
DATA IN ANY OF THE COLUMN  */
DELETE
FROM stage_locationdataraw 
WHERE Sensor_Id IS NULL AND Location_Name IS NULL AND latitude IS NULL AND longitude IS NULL AND elevation IS NULL AND region IS NULL;
DELETE
FROM stage_irrigationdataraw 
WHERE Sensor_Id IS NULL AND timestamp IS NULL AND irrigation_method IS NULL AND water_source IS NULL AND irrigation_duration_min IS NULL;
DELETE
FROM stage_cropdataraw 
WHERE timestamp IS NULL AND crop_type IS NULL AND crop_yield IS NULL AND growth_stage IS NULL AND pest_issue IS NULL;
DELETE
FROM stage_pestdataraw
WHERE timestamp IS NULL AND pest_type IS NULL AND pest_description IS NULL AND pest_severity IS NULL;
DELETE
FROM stage_sensordataraw 
WHERE Sensor_Id IS NULL AND timestamp IS NULL AND temperature_f IS NULL AND humidity IS NULL AND soil_moisture IS NULL AND light_intensity IS NULL AND battery_level IS NULL;	
DELETE
FROM stage_soildataraw 
WHERE timestamp IS NULL AND soil_comp IS NULL AND soil_moisture IS NULL AND soil_ph IS NULL AND nitrogen_level IS NULL AND phosphorus_level IS NULL AND organic_matter IS NULL;
DELETE
FROM stage_weatherdataraw 
WHERE timestamp IS NULL AND weather_condition IS NULL AND wind_speed IS NULL AND precipitation IS NULL;

/* TRANSFORM DATA TO THE RIGHT DATA TYPE */
ALTER TABLE stage_locationdataraw ALTER COLUMN Sensor_Id SET DATA TYPE VARCHAR(11);
ALTER TABLE stage_locationdataraw ALTER COLUMN Location_Name SET DATA TYPE VARCHAR(30);
ALTER TABLE stage_locationdataraw ALTER COLUMN latitude SET DATA TYPE DECIMAL(8, 6) USING latitude::DECIMAL(8, 6);
ALTER TABLE stage_locationdataraw ALTER COLUMN longitude SET DATA TYPE DECIMAL(9, 6) USING longitude::DECIMAL(9, 6);
ALTER TABLE stage_locationdataraw ALTER COLUMN elevation SET DATA TYPE DECIMAL(8, 2) USING elevation::DECIMAL(8, 2);
ALTER TABLE stage_locationdataraw ALTER COLUMN region SET DATA TYPE VARCHAR(20);

ALTER TABLE stage_irrigationdataraw ALTER COLUMN Sensor_Id SET DATA TYPE VARCHAR(11);
ALTER TABLE stage_irrigationdataraw ALTER COLUMN irrigation_method SET DATA TYPE VARCHAR(20);
ALTER TABLE stage_irrigationdataraw ALTER COLUMN water_source SET DATA TYPE VARCHAR(20);
ALTER TABLE stage_irrigationdataraw ALTER COLUMN timestamp SET DATA TYPE TIMESTAMP USING timestamp::TIMESTAMP;
ALTER TABLE stage_irrigationdataraw ALTER COLUMN irrigation_duration_min SET DATA TYPE INT USING irrigation_duration_min::INT;

ALTER TABLE stage_cropdataraw ALTER COLUMN crop_type SET DATA TYPE VARCHAR(20);
ALTER TABLE stage_cropdataraw ALTER COLUMN growth_stage SET DATA TYPE VARCHAR(50);
ALTER TABLE stage_cropdataraw ALTER COLUMN pest_issue SET DATA TYPE VARCHAR(20);
ALTER TABLE stage_cropdataraw ALTER COLUMN timestamp SET DATA TYPE TIMESTAMP USING timestamp::TIMESTAMP;
ALTER TABLE stage_cropdataraw ALTER COLUMN crop_yield SET DATA TYPE DECIMAL(8, 2) USING crop_yield::DECIMAL(8, 2);

ALTER TABLE stage_pestdataraw ALTER COLUMN pest_type SET DATA TYPE VARCHAR(20);
ALTER TABLE stage_pestdataraw ALTER COLUMN pest_description SET DATA TYPE TEXT;
ALTER TABLE stage_pestdataraw ALTER COLUMN pest_severity SET DATA TYPE VARCHAR(20);
ALTER TABLE stage_pestdataraw ALTER COLUMN timestamp SET DATA TYPE TIMESTAMP USING timestamp::TIMESTAMP;

ALTER TABLE stage_soildataraw ALTER COLUMN timestamp SET DATA TYPE TIMESTAMP USING timestamp::TIMESTAMP;
ALTER TABLE stage_soildataraw ALTER COLUMN soil_comp SET DATA TYPE DECIMAL(5, 2) USING soil_comp::DECIMAL(5, 2);
ALTER TABLE stage_soildataraw ALTER COLUMN soil_moisture SET DATA TYPE DECIMAL(5, 2) USING soil_moisture::DECIMAL(5, 2);
ALTER TABLE stage_soildataraw ALTER COLUMN soil_ph SET DATA TYPE DECIMAL(4, 2) USING soil_ph::DECIMAL(4, 2);
ALTER TABLE stage_soildataraw ALTER COLUMN nitrogen_level SET DATA TYPE DECIMAL(5, 2) USING nitrogen_level::DECIMAL(5, 2);
ALTER TABLE stage_soildataraw ALTER COLUMN phosphorus_level SET DATA TYPE DECIMAL(5, 2) USING phosphorus_level::DECIMAL(5, 2);
ALTER TABLE stage_soildataraw ALTER COLUMN organic_matter SET DATA TYPE DECIMAL(8, 2) USING organic_matter::DECIMAL(8, 2);

ALTER TABLE stage_sensordataraw ALTER COLUMN timestamp SET DATA TYPE TIMESTAMP USING timestamp::TIMESTAMP;
ALTER TABLE stage_sensordataraw ALTER COLUMN temperature_f SET DATA TYPE DECIMAL(5, 2) USING temperature_f::DECIMAL(5, 2);
ALTER TABLE stage_sensordataraw ALTER COLUMN humidity SET DATA TYPE DECIMAL(5, 2) USING humidity::DECIMAL(5, 2);
ALTER TABLE stage_sensordataraw ALTER COLUMN soil_moisture SET DATA TYPE DECIMAL(5, 2) USING soil_moisture::DECIMAL(5, 2);
ALTER TABLE stage_sensordataraw ALTER COLUMN light_intensity SET DATA TYPE DECIMAL(8, 2) USING light_intensity::DECIMAL(8, 2);
ALTER TABLE stage_sensordataraw ALTER COLUMN battery_level SET DATA TYPE DECIMAL(8, 2) USING battery_level::DECIMAL(8, 2);

ALTER TABLE stage_weatherdataraw ALTER COLUMN timestamp SET DATA TYPE TIMESTAMP USING timestamp::TIMESTAMP;
ALTER TABLE stage_weatherdataraw ALTER COLUMN weather_condition SET DATA TYPE VARCHAR(50);
ALTER TABLE stage_weatherdataraw ALTER COLUMN wind_speed SET DATA TYPE DECIMAL(5, 2) USING wind_speed::DECIMAL(5, 2);
ALTER TABLE stage_weatherdataraw ALTER COLUMN precipitation SET DATA TYPE DECIMAL(5, 2) USING precipitation::DECIMAL(5, 2);

/* Count the number of duplicate columns
Check the occurrences of each column in the 
table and identify columns that have duplicate values to remove
Perform the action for eact table.
*/
SELECT column_name, COUNT(column_name) AS duplicate_count
FROM information_schema.columns
WHERE table_name = 'table_name'
GROUP BY column_name
HAVING COUNT(column_name) > 1;

/*
To find columns with duplicate values in a SQL table, 
I use this generic query to resolve columns with duplicate 
values where unique value is expected:
*/
SELECT COUNT(*) AS NumberOfDuplicates, columnn_name
FROM table_name
GROUP BY columnn_name
HAVING (COUNT(*) > 1);

/* Data Validation Query: 
This query checks if certain data meets predefined criteria.
Use especially in tables that return percentage values
*/
SELECT *
FROM your_table
WHERE column_name < minimum_value OR column_name > maximum_value;

/*
Duplicate Data Check: 
This query identifies duplicate records in a table.
*/
SELECT column1, column2, COUNT(*)
FROM your_table
GROUP BY column1, column2
HAVING COUNT(*) > 1;


/*
Data Consistency Check: 
This query checks for inconsistent data within a table.
*/
SELECT *
FROM your_table
WHERE column1 <> column2;

/*
Data Completeness Check: 
This query verifies if essential data is missing.
*/
SELECT *
FROM your_table
WHERE column_name IS NULL;

/*
Data Range Check: 
This query ensures that data falls within a specified range.
Used for percentage values
*/
SELECT *
FROM your_table
WHERE column_name NOT BETWEEN min_value AND max_value;


/*
Data Integrity Check: 
This query checks for referential integrity between related tables.
*/
SELECT *
FROM table1
WHERE NOT EXISTS (
    SELECT 1
    FROM table2
    WHERE table1.column_name = table2.column_name
);

/*
Performance Testing Query: 
This query measures the performance of a database operation.
*/
SELECT *
FROM your_table
WHERE [your_condition]
ORDER BY [your_indexed_column]
LIMIT [your_limit];

/*
Regression Testing Query: 
This query compares current data with a baseline to detect regressions.
*/
SELECT *
FROM current_data
EXCEPT
SELECT *
FROM baseline_data;


/*
Data Transformation Check: If your QA process involves data transformation, 
this query checks if the transformation was successful.
*/
SELECT *
FROM transformed_data
WHERE [transformation_condition];
