/* Day 1 Task 2: Schema Setup, Data Cleansing and Transformation
Create the schema for the data warehouse.
Cleanse and preprocess the data in the staging tables.
Handle missing values, data type conversions, and data quality checks.
Transform the data into a format suitable for fact and dimension Tables.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day1-task2.sql).
*/

<<<<<<< HEAD

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
=======
/* STEP 1 - CREATE STAGE TABLES WITH THE RIGHT DATATYPE */
CREATE TABLE stagelocationdata (
    id BIGSERIAL NOT NULL,
    sensorid VARCHAR (20),
    locationname VARCHAR (30),
    latitude DECIMAL(8, 6),
    longitude DECIMAL(9, 6),
    elevation DECIMAL(8, 2),
    region VARCHAR (20)
);
CREATE TABLE stageirrigationdata (
    id BIGSERIAL NOT NULL,
    sensorid VARCHAR (20),
	timestamp TIMESTAMP,
	irrigationmethod VARCHAR(20),
	watersource VARCHAR(20),
	irrigationdurationmin INTEGER
);
CREATE TABLE stagecropdata (
    id BIGSERIAL NOT NULL,
	timestamp TIMESTAMP,
	croptype VARCHAR(20),
	cropyield DECIMAL(8, 2),
	growthstage VARCHAR(50),
	pestissue VARCHAR(100)
);
CREATE TABLE stagepestdata (
    id BIGSERIAL NOT NULL,
	timestamp TIMESTAMP,
	pesttype VARCHAR(20),
	pestdescription TEXT,
	pestseverity VARCHAR(20)
);
CREATE TABLE stagesoildata (
    id BIGSERIAL NOT NULL,
	timestamp TIMESTAMP,
	soilcomp DECIMAL(5, 2),
	soilmoisture DECIMAL(5, 2),
	soilph DECIMAL(4, 2),
	nitrogenlevel DECIMAL(5, 2),
	phosphoruslevel DECIMAL(5, 2),
	organicmatter DECIMAL(5, 2)
);
CREATE TABLE stageweatherdata (
    id BIGSERIAL NOT NULL,
	timestamp TIMESTAMP,
	weathercondition VARCHAR(50),
	windspeed DECIMAL(5, 2),
	precipitation DECIMAL(5, 2)
);
CREATE TABLE stagesensordata (
    id BIGSERIAL NOT NULL,
    sensorid VARCHAR (10),
	timestamp TIMESTAMP,
	temperaturef DECIMAL(5, 2),
	humidity DECIMAL(5, 2),
	soilmoisture DECIMAL(5, 2),
	lightintensity DECIMAL(8, 2),
	batterylevel DECIMAL(8, 2)
);

/* STEP 2 - ALTER RAW COLUMN NAME */
ALTER TABLE locationdataraw RENAME COLUMN Sensor_Id TO sensorid;
ALTER TABLE locationdataraw RENAME COLUMN Location_Name TO locationname;
ALTER TABLE irrigationdataraw RENAME COLUMN Sensor_Id TO sensorid;
ALTER TABLE irrigationdataraw RENAME COLUMN irrigationmethod TO irrigationmethod;
ALTER TABLE irrigationdataraw RENAME COLUMN watersource TO watersource;
ALTER TABLE irrigationdataraw RENAME COLUMN irrigationdurationmin TO irrigationdurationmin;
ALTER TABLE cropdataraw RENAME COLUMN Crop_Type TO croptype;
ALTER TABLE cropdataraw RENAME COLUMN cropyield TO cropyield;
ALTER TABLE cropdataraw RENAME COLUMN growthstage TO growthstage;
ALTER TABLE cropdataraw RENAME COLUMN pestissue TO pestissue;
ALTER TABLE pestdataraw RENAME COLUMN pesttype TO pesttype;
ALTER TABLE pestdataraw RENAME COLUMN pestdescription TO pestdescription;
ALTER TABLE pestdataraw RENAME COLUMN pestseverity TO pestseverity;
ALTER TABLE soildataraw RENAME COLUMN soilcomp TO soilcomp;
ALTER TABLE soildataraw RENAME COLUMN soilmoisture TO soilmoisture;
ALTER TABLE soildataraw RENAME COLUMN soilph TO soilph;
ALTER TABLE soildataraw RENAME COLUMN nitrogenlevel TO nitrogenlevel;
ALTER TABLE soildataraw RENAME COLUMN phosphoruslevel TO phosphoruslevel;
ALTER TABLE soildataraw RENAME COLUMN organicmatter TO organicmatter;
ALTER TABLE weatherdataraw RENAME COLUMN weathercondition TO weathercondition;
ALTER TABLE weatherdataraw RENAME COLUMN windspeed TO windspeed;
ALTER TABLE sensordataraw RENAME COLUMN Sensor_Id TO sensorid;
ALTER TABLE sensordataraw RENAME COLUMN temperaturef TO temperatureff;
ALTER TABLE sensordataraw RENAME COLUMN soilmoisture TO soilmoisture;
ALTER TABLE sensordataraw RENAME COLUMN lightintensity TO lightintensity;
ALTER TABLE sensordataraw RENAME COLUMN Battery_Level TO batterylevel;

/* CHANGE DATA VALUES FROM NA TO NULL OR OTHER TEXT */
UPDATE irrigationdataraw 
SET irrigationdurationmin = NULL 
WHERE irrigationdurationmin LIKE '%NA%';

UPDATE cropdataraw 
SET cropyield = NULL 
WHERE cropyield LIKE '%NA%';

UPDATE cropdataraw 
SET growthstage = 'Not Sure' 
WHERE growthstage LIKE '%NA%';

UPDATE soildataraw 
SET soilcomp = NULL 
WHERE soilcomp LIKE '%NA%';

UPDATE soildataraw 
SET soilmoisture = NULL 
WHERE soilmoisture LIKE '%NA%';

UPDATE soildataraw 
SET soilph = NULL 
WHERE soilph LIKE '%NA%';

UPDATE soildataraw 
SET nitrogenlevel = NULL 
WHERE nitrogenlevel LIKE '%NA%';

UPDATE soildataraw 
SET phosphoruslevel = NULL 
WHERE phosphoruslevel LIKE '%NA%';

UPDATE soildataraw 
SET organicmatter = NULL 
WHERE organicmatter LIKE '%NA%';

UPDATE weatherdataraw 
SET windspeed = NULL 
WHERE windspeed LIKE '%NA%';

UPDATE weatherdataraw 
SET precipitation = NULL 
WHERE precipitation LIKE '%NA%';

UPDATE sensordataraw 
SET temperaturef = NULL 
WHERE temperaturef LIKE '%NA%';

UPDATE sensordataraw 
SET humidity = NULL 
WHERE humidity LIKE '%NA%';

UPDATE sensordataraw 
SET soilmoisture = NULL 
WHERE soilmoisture LIKE '%NA%';

UPDATE sensordataraw 
SET lightintensity = NULL 
WHERE lightintensity LIKE '%NA%';

/* INSERT INTO STAGE DATA FROM IMPORTED RAW DATA
The table being imported into have the right column name.
This table now serve as raw data to create dimension tables */
 */
INSERT INTO stagelocationdata (sensorid, locationname, latitude, longitude, elevation)
SELECT sensorid, locationname,
    latitude::DECIMAL(8, 6), longitude::DECIMAL(9, 6), elevation::DECIMAL(8, 2), region FROM locationdataraw;

INSERT INTO stageirrigationdata (sensorid, timestamp, irrigationmethod, watersource, irrigationdurationmin) 
SELECT sensorid, timestamp::TIMESTAMP, 
    irrigationmethod, watersource, irrigationdurationmin::INTEGER FROM irrigationdataraw;

INSERT INTO stagecropdata (timestamp, croptype, cropyield, growthstage, pestissue)
SELECT timestamp::TIMESTAMP, croptype, 
    cropyield::DECIMAL(8, 2), growthstage, pestissue FROM cropdataraw;

INSERT INTO stagepestdata (Timestamp, pesttype, pestdescription, pestseverity)
SELECT timestamp::TIMESTAMP, pesttype, pestdescription, pestseverity FROM pestdataraw;

INSERT INTO stagesoildata (timestamp, soilcomp, soilmoisture, soilph, nitrogenlevel, phosphoruslevel, organicmatter)
SELECT timestamp::TIMESTAMP, soilcomp::DECIMAL(5, 2), 
    soilmoisture::DECIMAL(5, 2), soilph::DECIMAL(4, 2), nitrogenlevel::DECIMAL(5, 2), phosphoruslevel::DECIMAL(5, 2), organicmatter::DECIMAL(5, 2) FROM soildataraw;

INSERT INTO stageweatherdata (timestamp, weathercondition, windspeed, precipitation)
SELECT timestamp::TIMESTAMP, weathercondition, 
    windspeed::DECIMAL(5, 2), precipitation::DECIMAL(5, 2) FROM weatherdataraw;

INSERT INTO stagesensordata (sensorid, timestamp, temperaturef, humidity, soilmoisture, lightintensity, batterylevel)
SELECT sensorid, timestamp::TIMESTAMP, 
     temperaturef::DECIMAL(5, 2), humidity::DECIMAL(5, 2), soilmoisture::DECIMAL(5, 2), lightintensity::DECIMAL(8, 2), batterylevel::DECIMAL(8, 2) FROM sensordataraw;


/* FIND AND DELETE NULL VALUES IN ALL COLUMN OF TABLE DATA */
DELETE
FROM stagelocationdata 
WHERE sensorid IS NULL AND locationname IS NULL AND latitude IS NULL AND longitude IS NULL AND elevation IS NULL AND region IS NULL;

SELECT *
FROM stageirrigationdata 
WHERE sensorid IS NULL AND timestamp IS NULL AND irrigationmethod IS NULL AND watersource IS NULL AND irrigationdurationmin IS NULL;

DELETE
FROM stagecropdata 
WHERE timestamp IS NULL AND croptype IS NULL AND cropyield IS NULL AND growthstage IS NULL AND pestissue IS NULL;

SELECT *
FROM stagepestdata
WHERE timestamp IS NULL AND pesttype IS NULL AND pestdescription IS NULL AND pestseverity IS NULL;

SELECT *
FROM stagesensordata 
WHERE sensorid IS NULL AND timestamp IS NULL AND temperaturef IS NULL AND humidity IS NULL AND soilmoisture IS NULL AND lightintensity IS NULL AND batterylevel IS NULL;	

DELETE
FROM stagesoildata 
WHERE timestamp IS NULL AND soilcomp IS NULL AND soilmoisture IS NULL AND soilph IS NULL AND nitrogenlevel IS NULL AND phosphoruslevel IS NULL AND organicmatter IS NULL;

DELETE
FROM stageweatherdata 
WHERE timestamp IS NULL AND weathercondition IS NULL AND windspeed IS NULL AND precipitation IS NULL;

/* UPDATE MISSPELT WORD */
UPDATE stagecropdata 
SET growthstage = 'Flowering' 
WHERE growthstage = 'Flowerring';
UPDATE stagecropdata 
SET growthstage = 'Vegetative' 
WHERE growthstage = 'Vegatative';

UPDATE stagecropdata
SET pestissue = 'Aphids' 
WHERE pestissue = 'Aphidds';
UPDATE stagecropdata
SET pestissue = 'Not Sure' 
WHERE pestissue = 'NA';
UPDATE stageirrigationdata 
SET irrigationmethod = 'Drip' 
WHERE irrigationmethod = 'Driip';
UPDATE stageirrigationdata
SET watersource = 'River' 
WHERE watersource = 'Rivver';
UPDATE stageirrigationdata 
SET watersource = 'Well' 
WHERE watersource = 'Wel';
UPDATE stageirrigationdata 
SET irrigationmethod = 'Sprinkler' 
WHERE irrigationmethod = 'Spinkler';
UPDATE stagepestdata 
SET pesttype = 'Aphids' 
WHERE pesttype = 'Aphiods';
UPDATE stagepestdata 
SET pesttype = 'Slugs' 
WHERE pesttype = 'Slogs';

/*UPDATE PESTDATARAW pestdescription replace all occurence of wrong spelling*/
UPDATE stagepestdata 
SET pestdescription = REPLACE(pestdescription, 'Slogs','Slugs');

UPDATE stagepestdata 
SET pestdescription = REPLACE(pestdescription, 'Aphiods','Aphids');

UPDATE stagepestdata 
SET pestdescription = REPLACE(pestdescription, 'deteced','detected');

UPDATE stagepestdata 
SET pestdescription = REPLACE(pestdescription, 'riskkk','risk');

UPDATE stagepestdata 
SET pestseverity = 'High' 
WHERE pestseverity = 'Hihg';

UPDATE stageweatherdata 
SET weathercondition = 'Clear' 
WHERE weathercondition = 'Claar';

UPDATE stageweatherdata 
SET weathercondition = 'Partly Cloudy' 
WHERE weathercondition = 'Party Cloudy';

/* Set Pest description to null where NA is provided */
UPDATE stagepestdata SET pestdescription = NULL where pestdescription = 'NA';

/*REMOVE TRAILING CHARACTER FROM COLUMN VALUES */
UPDATE stagesensordata SET sensorid = REPLACE(sensorid, '"', '');
UPDATE stageirrigationdata SET sensorid = REPLACE(sensorid, '*', '');

/* SPLIT SENDOR_ID VALUE TO EXTRACT REGULAR EXPRESSION */
UPDATE stageirrigationdata SET sensorid = SPLIT_PART(sensorid, '_', 2);
UPDATE stagelocationdata SET sensorid = SPLIT_PART(sensorid, '_', 2);
>>>>>>> 7edb145683e9357a0978bd5769a18b764237a5d0
