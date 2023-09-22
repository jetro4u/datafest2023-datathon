/* # Day 1 Task 1: Data Ingestion
Load the raw data from all source tables (SensorDataRaw, WeatherDataRaw, 
SoilDataRaw, CropDataRaw, PestDataRaw, IrrigationDataRaw, LocationDataRaw) 
into staging tables within the Data Warehouse Schema.
*/

/* STEP 1 - LOAD TABLE FROM RAW DATA TO DATAORBIQ STAGE SCHEMA IN SNOWFLAKE AND DOWNLOAD TO MY SYSTEM */
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_LOCATIONDATARAW CLONE DFA23RAWDATA.RAWDATA.LOCATIONDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_IRRIGATIONDATARAW CLONE DFA23RAWDATA.RAWDATA.IRRIGATIONDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_CROPDATARAW CLONE DFA23RAWDATA.RAWDATA.CROPDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_PESTDATARAW CLONE DFA23RAWDATA.RAWDATA.PESTDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_SENSORDATARAW CLONE DFA23RAWDATA.RAWDATA.SENSORDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_SOILDATARAW CLONE DFA23RAWDATA.RAWDATA.SOILDATARAW;
CREATE TABLE DFA23RAWDATA.DATAORBIQ.STAGE_WEATHERDATARAW CLONE DFA23RAWDATA.RAWDATA.WEATHERDATARAW;

/* STEP 2 - CREATE STAGE TABLE IN POSTGRESQL */
create table locationdataraw (
	SENSOR_ID VARCHAR(30),
	LOCATION_NAME VARCHAR(150),
	LATITUDE VARCHAR(100),
	LONGITUDE VARCHAR(100),
	ELEVATION VARCHAR(100),
	REGION VARCHAR(100)
);
create table irrigationdataraw (
	SENSOR_ID VARCHAR(1000),
	TIMESTAMP VARCHAR(1000),
	IRRIGATION_METHOD VARCHAR(1000),
	WATER_SOURCE VARCHAR(1000),
	IRRIGATION_DURATION_MIN VARCHAR(1000)
);
create table cropdataraw (
	TIMESTAMP VARCHAR(1000),
	CROP_TYPE VARCHAR(1000),
	CROP_YIELD VARCHAR(1000),
	GROWTH_STAGE VARCHAR(1000),
	PEST_ISSUE VARCHAR(1000)
);
create table pestdataraw (
	TIMESTAMP VARCHAR(1000),
	PEST_TYPE VARCHAR(1000),
	PEST_DESCRIPTION VARCHAR(1000),
	PEST_SEVERITY VARCHAR(1000)
);
create table sensordataraw (
	SENSOR_ID VARCHAR(1000),
	TIMESTAMP VARCHAR(1000),
	TEMPERATURE VARCHAR(1000),
	HUMIDITY VARCHAR(1000),
	SOIL_MOISTURE VARCHAR(1000),
	LIGHT_INTENSITY VARCHAR(1000),
	BATTERY_LEVEL VARCHAR(1000)
);
create table soildataraw (
	TIMESTAMP VARCHAR(1000),
	SOIL_COMP VARCHAR(1000),
	SOIL_MOISTURE VARCHAR(1000),
	SOIL_PH VARCHAR(1000),
	NITROGEN_LEVEL VARCHAR(1000),
	PHOSPHORUS_LEVEL VARCHAR(1000),
	ORGANIC_MATTER VARCHAR(1000)
);
create table weatherdataraw (
	TIMESTAMP VARCHAR(1000),
	WEATHER_CONDITION VARCHAR(1000),
	WIND_SPEED VARCHAR(1000),
	PRECIPITATION VARCHAR(1000)
);

/* STEP 2 - CREATE STAGE TABLE IN POSTGRESQL */
create table stage_locationdataraw (
	SENSOR_ID VARCHAR(1000),
	LOCATION_NAME VARCHAR(1000),
	LATITUDE VARCHAR(1000),
	LONGITUDE VARCHAR(1000),
	ELEVATION VARCHAR(1000),
	REGION VARCHAR(1000)
);
create table stage_irrigationdataraw (
	SENSOR_ID VARCHAR(1000),
	TIMESTAMP VARCHAR(1000),
	IRRIGATION_METHOD VARCHAR(1000),
	WATER_SOURCE VARCHAR(1000),
	IRRIGATION_DURATION_MIN VARCHAR(1000)
);
create table stage_cropdataraw (
	TIMESTAMP VARCHAR(1000),
	CROP_TYPE VARCHAR(1000),
	CROP_YIELD VARCHAR(1000),
	GROWTH_STAGE VARCHAR(1000),
	PEST_ISSUE VARCHAR(1000)
);
create table stage_pestdataraw (
	TIMESTAMP VARCHAR(1000),
	PEST_TYPE VARCHAR(1000),
	PEST_DESCRIPTION VARCHAR(1000),
	PEST_SEVERITY VARCHAR(1000)
);
create table stage_sensordataraw (
	SENSOR_ID VARCHAR(1000),
	TIMESTAMP VARCHAR(1000),
	TEMPERATURE_F VARCHAR(1000),
	HUMIDITY VARCHAR(1000),
	SOIL_MOISTURE VARCHAR(1000),
	LIGHT_INTENSITY VARCHAR(1000),
	BATTERY_LEVEL VARCHAR(1000)
);
create table stage_soildataraw (
	TIMESTAMP VARCHAR(1000),
	SOIL_COMP VARCHAR(1000),
	SOIL_MOISTURE VARCHAR(1000),
	SOIL_PH VARCHAR(1000),
	NITROGEN_LEVEL VARCHAR(1000),
	PHOSPHORUS_LEVEL VARCHAR(1000),
	ORGANIC_MATTER VARCHAR(1000)
);
create table stage_weatherdataraw (
	TIMESTAMP VARCHAR(1000),
	WEATHER_CONDITION VARCHAR(1000),
	WIND_SPEED VARCHAR(1000),
	PRECIPITATION VARCHAR(1000)
);

/* STEP 3 - COPY RAW DATA FILE TO POSTGRES TABLES */
COPY stage_locationdataraw
FROM 'C:\Users\Hp\Downloads\LOCATIONDATARAW.csv'
DELIMITER ','
CSV HEADER;

COPY stage_irrigationdataraw
FROM 'C:\Users\Hp\Downloads\IRRIGATIONDATARAW.csv'
DELIMITER ','
CSV HEADER;

COPY stage_cropdataraw
FROM 'C:\Users\Hp\Downloads\CROPDATARAW.csv'
DELIMITER ','
CSV HEADER;

COPY stage_pestdataraw
FROM 'C:\Users\Hp\Downloads\PESTDATARAW.csv'
DELIMITER ','
CSV HEADER;

COPY stage_sensordataraw
FROM 'C:\Users\Hp\Downloads\SENSORDATARAW.csv'
DELIMITER ','
CSV HEADER;

COPY stage_soildataraw
FROM 'C:\Users\Hp\Downloads\SOILDATARAW.csv'
DELIMITER ','
CSV HEADER;

COPY stage_weatherdataraw
FROM 'C:\Users\Hp\Downloads\WEATHERDATARAW.csv'
DELIMITER ','
CSV HEADER;