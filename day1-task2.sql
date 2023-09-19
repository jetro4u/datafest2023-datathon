/* Day 1 Task 2: Schema Setup, Data Cleansing and Transformation
Create the schema for the data warehouse.
Cleanse and preprocess the data in the staging tables.
Handle missing values, data type conversions, and data quality checks.
Transform the data into a format suitable for fact and dimension Tables.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day1-task2.sql).
*/

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
