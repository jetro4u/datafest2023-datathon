/* # Task 1: Data Ingestion
Load the raw data from all source tables (SensorDataRaw, WeatherDataRaw, 
SoilDataRaw, CropDataRaw, PestDataRaw, IrrigationDataRaw, LocationDataRaw) 
into staging tables within the Data Warehouse Schema.
*/

/* LOAD TABLE FROM RAW DATA TO DATAORBIQ STAGE SCHEMA */
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_LOCATIONRAWDATA CLONE DFA23RAWDATA.RAWDATA.LOCATIONDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA CLONE DFA23RAWDATA.RAWDATA.IRRIGATIONDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_CROPRAWDATA CLONE DFA23RAWDATA.RAWDATA.CROPDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA CLONE DFA23RAWDATA.RAWDATA.PESTDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA CLONE DFA23RAWDATA.RAWDATA.SENSORDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA CLONE DFA23RAWDATA.RAWDATA.SOILDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_WEATHERRAWDATA CLONE DFA23RAWDATA.RAWDATA.WEATHERDATARAW;


/* Task 2: Schema Setup, Data Cleansing and Transformation
Create the schema for the data warehouse.
Cleanse and preprocess the data in the staging tables.
Handle missing values, data type conversions, and data quality checks.
Transform the data into a format suitable for fact and dimension Tables.
*/

/* CLEANING NULL VALUES */
DELETE FROM DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA WHERE SENSOR_ID is NULL;
DELETE FROM DFA23RAWDATA.DATAORBIQ.STAGE_LOCATIONRAWDATA WHERE SENSOR_ID is NULL;
DELETE FROM DFA23RAWDATA.DATAORBIQ.STAGE_CROPRAWDATA WHERE TIMESTAMP is NULL;
DELETE FROM DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA WHERE TIMESTAMP is NULL;
DELETE FROM DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA WHERE SENSOR_ID is NULL;
DELETE FROM DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA WHERE TIMESTAMP is NULL;
DELETE FROM DFA23RAWDATA.DATAORBIQ.STAGE_WEATHERRAWDATA WHERE TIMESTAMP is NULL;

/* UPDATE MISSPELT WORD */
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_CROPRAWDATA 
SET GROWTH_STAGE = 'Flowering' 
WHERE GROWTH_STAGE = 'Flowerring';

/*UPDATE 33.5K CROPDATARAW GROWTH_STAGE value from Vegatative to Vegetative*/
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_CROPRAWDATA 
SET GROWTH_STAGE = 'Vegetative' 
WHERE GROWTH_STAGE = 'Vegatative';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_CROPRAWDATA  
SET PEST_ISSUE = 'No Pest Issue' 
WHERE PEST_ISSUE = 'NA';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_CROPRAWDATA
SET PEST_ISSUE = 'Aphids' 
WHERE PEST_ISSUE = 'Aphidds';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA 
SET IRRIGATION_METHOD = 'Drip' 
WHERE IRRIGATION_METHOD = 'Driip';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA
SET WATER_SOURCE = 'River' 
WHERE WATER_SOURCE = 'Rivver';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA 
SET WATER_SOURCE = 'Well' 
WHERE WATER_SOURCE = 'Wel';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA 
SET PEST_TYPE = 'Aphids' 
WHERE PEST_TYPE = 'Aphiods';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA 
SET PEST_TYPE = 'Slugs' 
WHERE PEST_TYPE = 'Slogs';

/*UPDATE PESTDATARAW PEST_DESCRIPTION replace all occurence of wrong spelling*/
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA 
SET PEST_DESCRIPTION = REPLACE(PEST_DESCRIPTION, 'Slogs','Slugs');

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA 
SET PEST_DESCRIPTION = REPLACE(PEST_DESCRIPTION, 'Aphiods','Aphids');

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA 
SET PEST_DESCRIPTION = REPLACE(PEST_DESCRIPTION, 'deteced','detected');

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA 
SET PEST_DESCRIPTION = REPLACE(PEST_DESCRIPTION, 'riskkk','risk');

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA 
SET PEST_SEVERITY = 'High' 
WHERE PEST_SEVERITY = 'Hihg';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_WEATHERRAWDATA 
SET WEATHER_CONDITION = 'Clear' 
WHERE WEATHER_CONDITION = 'Claar';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_WEATHERRAWDATA 
SET WEATHER_CONDITION = 'Partly Cloudy' 
WHERE WEATHER_CONDITION = 'Party Cloudy';

/* CHANGE DATA VALUES FROM NA TO NULL */
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA 
SET IRRIGATION_DURATION_MIN = NULL 
WHERE IRRIGATION_DURATION_MIN LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_CROPRAWDATA 
SET CROP_YIELD = NULL 
WHERE CROP_YIELD LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA 
SET TEMPERATURE = NULL 
WHERE TEMPERATURE LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA 
SET HUMIDITY = NULL 
WHERE HUMIDITY LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA 
SET SOIL_MOISTURE = NULL 
WHERE SOIL_MOISTURE LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA 
SET LIGHT_INTENSITY = NULL 
WHERE LIGHT_INTENSITY LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA 
SET SOIL_COMP = NULL 
WHERE SOIL_COMP LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA 
SET SOIL_MOISTURE = NULL 
WHERE SOIL_MOISTURE LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA 
SET SOIL_PH = NULL 
WHERE SOIL_PH LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA 
SET NITROGEN_LEVEL = NULL 
WHERE NITROGEN_LEVEL LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA 
SET PHOSPHORUS_LEVEL = NULL 
WHERE PHOSPHORUS_LEVEL LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SOILRAWDATA 
SET ORGANIC_MATTER = NULL 
WHERE ORGANIC_MATTER LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_WEATHERRAWDATA 
SET WIND_SPEED = NULL 
WHERE WIND_SPEED LIKE '%NA%';

UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_WEATHERRAWDATA 
SET PRECIPITATION = NULL 
WHERE PRECIPITATION LIKE '%NA%';

/* Set Pest description to null where NA is provided */
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_PESTRAWDATA SET PEST_DESCRIPTION = NULL where PEST_DESCRIPTION = 'NA';

/*REMOVE TRAILING CHARACTER FROM COLUMN VALUES */
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA SET SENSOR_ID = REPLACE(SENSOR_ID, '"', '');
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORRAWDATA SET timestamp = REPLACE(timestamp, '"', '');
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA SET SENSOR_ID = REPLACE(SENSOR_ID, '*', '');

/* SPLIT SENDOR_ID VALUE TO EXTRACT REGULAR EXPRESSION */
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONRAWDATA SET SENSOR_ID = SPLIT_PART(SENSOR_ID, '_', 2);
UPDATE DFA23RAWDATA.DATAORBIQ.STAGE_LOCATIONRAWDATA SET SENSOR_ID = SPLIT_PART(SENSOR_ID, '_', 2);
