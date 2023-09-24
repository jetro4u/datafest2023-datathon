/*** INSTRUCTION 
Task 1: Create Dimension Tables
Based on the cleaned and transformed data, create dimension Tables for 
attributes such as Location, Time, Crop Type, Pest Type, and Irrigation
 Method.
Populate these dimension tables.
***/

/* CREATE AND POPULATE LOCATION DIMENSION TABLE AND REGION SUB DIMENSION TABLE
With SQL query to append string to duplicate location name
 */

CREATE TABLE Location (
    LocationID SERIAL PRIMARY KEY,
    Sensor_ID VARCHAR(100),
    Sensor_Type VARCHAR(100),
    Location_Name VARCHAR(100),
    Latitude VARCHAR(100),
    Longitude VARCHAR(100),
    Elevation VARCHAR(100),
    Region VARCHAR(100)
);
CREATE TABLE Location_Region (
    Region_Id SERIAL PRIMARY KEY,
    LocationID INT REFERENCES Location(LocationID),
    Region_Name VARCHAR(20)
);

INSERT INTO Location (Location_Name, Sensor_Id, Sensor_Type, Latitude, Longitude, Elevation, Region)
with tab as (
SELECT DISTINCT Location_Name, Sensor_Id, Sensor_Id as Sensor_Type, Latitude, Longitude, Elevation, Region,
       ROW_NUMBER() OVER(PARTITION BY Location_Name ORDER BY Sensor_Id) As Occurence
FROM stage_locationdataraw
)
SELECT 
  Location_Name || 
  case when Occurence = 1 then '_A' 
  when Occurence = 2 then '_B' else '_C' 
  end as Location_Name, 
  Sensor_Id, Sensor_Type, Latitude, Longitude, Elevation, Region
FROM tab;

INSERT INTO Location_Region (locationid, region_name)
SELECT DISTINCT ld.locationid, lr.region_name
FROM Location ld
JOIN (
    SELECT DISTINCT region AS region_name
    FROM stage_locationdataraw
) lr ON ld.region = lr.region_name;

UPDATE Location SET Sensor_Id = REPLACE(Sensor_Id, '*', '');
UPDATE Location SET Sensor_Id = REPLACE(Sensor_Id, '_', '');
UPDATE Location SET Sensor_Id = REPLACE(Sensor_Id, '#', '');

UPDATE Location SET Sensor_Type = SPLIT_PART(Sensor_Type, '_', 2);

/* TRANSFORM DATA TO THE RIGHT DATA TYPE */
ALTER TABLE Location ALTER COLUMN Sensor_Id SET DATA TYPE VARCHAR(11);
ALTER TABLE Location ALTER COLUMN Sensor_Type SET DATA TYPE VARCHAR(5);
ALTER TABLE Location ALTER COLUMN Location_Name SET DATA TYPE VARCHAR(30);
ALTER TABLE Location ALTER COLUMN latitude SET DATA TYPE DECIMAL(8, 6) USING latitude::DECIMAL(8, 6);
ALTER TABLE Location ALTER COLUMN longitude SET DATA TYPE DECIMAL(9, 6) USING longitude::DECIMAL(9, 6);
ALTER TABLE Location ALTER COLUMN elevation SET DATA TYPE DECIMAL(8, 2) USING elevation::DECIMAL(8, 2);
ALTER TABLE Location ALTER COLUMN region SET DATA TYPE VARCHAR(20);


/* 
CREATE AND POPULATE IRRIGATION DIMENSION TABLE 
 */
-- Create the IrrigationMethod table
CREATE TABLE IrrigationMethod (
    IrrigationMethodID SERIAL PRIMARY KEY,
    Irrigation_Method VARCHAR(20) UNIQUE
);

-- Create the WaterSource table
CREATE TABLE WaterSource (
    WaterSourceID SERIAL PRIMARY KEY,
    Water_Source VARCHAR(20) UNIQUE
);

-- Create the IrrigationDimension table
CREATE TABLE IrrigationDimension (
    IrrigationId BIGSERIAL PRIMARY KEY,
    Sensor_ID VARCHAR(100),
    Sensor_Type VARCHAR(100),
    Timestamp VARCHAR(100),
    Irrigation_Method VARCHAR(20),
    Water_Source VARCHAR(20),
    Irrigation_Duration_Min VARCHAR(100)
);

-- Populate the irrigation_method dim table
INSERT INTO IrrigationMethod (Irrigation_Method)
SELECT DISTINCT Irrigation_Method FROM stage_irrigationdataraw;

-- Populate the water_source dim table
INSERT INTO WaterSource (Water_Source)
SELECT DISTINCT Water_Source FROM stage_irrigationdataraw;

-- Populate Irrigation Dimension Table
INSERT INTO IrrigationDimension (Sensor_ID, Sensor_Type, Timestamp, Irrigation_Method, Water_Source, Irrigation_Duration_Min)
SELECT
    id.Sensor_ID,
    id.Sensor_ID as Sensor_Type,
    id.Timestamp,
    im.Irrigation_Method,
    ws.Water_Source,
    id.Irrigation_Duration_Min
FROM stage_irrigationdataraw id
JOIN IrrigationMethod im ON im.Irrigation_Method = id.Irrigation_Method
JOIN WaterSource ws ON ws.Water_Source = id.Water_Source;

UPDATE IrrigationDimension SET Sensor_Id = REPLACE(Sensor_Id, '*', '');
UPDATE IrrigationDimension SET Sensor_Id = REPLACE(Sensor_Id, '_', '');
UPDATE IrrigationDimension SET Sensor_Id = REPLACE(Sensor_Id, '#', '');

UPDATE IrrigationDimension SET Sensor_Type = SPLIT_PART(Sensor_Type, '_', 2);

/* TRANSFORM DATA TO THE RIGHT DATA TYPE */

ALTER TABLE IrrigationDimension ALTER COLUMN Sensor_Id SET DATA TYPE VARCHAR(11);
ALTER TABLE IrrigationDimension ALTER COLUMN irrigation_method SET DATA TYPE VARCHAR(20);
ALTER TABLE IrrigationDimension ALTER COLUMN water_source SET DATA TYPE VARCHAR(20);
ALTER TABLE IrrigationDimension ALTER COLUMN timestamp SET DATA TYPE TIMESTAMP USING timestamp::TIMESTAMP;
ALTER TABLE IrrigationDimension ALTER COLUMN irrigation_duration_min SET DATA TYPE INT USING irrigation_duration_min::INT;


/* 
CREATE AND POPULATE CROP TYPE DIMENSION TABLE 
 */
CREATE TABLE CropType (
    CropTypeId SERIAL PRIMARY KEY,
	Crop_Type VARCHAR(20) UNIQUE
);
CREATE TABLE CropDimension (
    CropId BIGSERIAL PRIMARY KEY,
	Timestamp TIMESTAMP,
	Crop_Type VARCHAR(20) REFERENCES CropType(Crop_Type),
	Growth_Stage VARCHAR(50),
	Pest_Issue TEXT,
	Crop_yield DECIMAL(8, 2)
);

-- Populate the crop_type dim table
INSERT INTO CropType (Crop_Type)
SELECT DISTINCT Crop_Type FROM stage_cropdataraw;

-- Populate the crop dim table
INSERT INTO CropDimension (Crop_Type, Timestamp, Growth_Stage, Pest_Issue, Crop_yield)
SELECT
    Crop_Type,
    Timestamp,
    Growth_Stage,
    Pest_Issue,
    Crop_yield
FROM stage_cropdataraw;

/* 
CREATE AND POPULATE PEST DIMENSION TABLE 
 */
 -- Create the pest_type dimension table
CREATE TABLE PestType (
    PestTypeID SERIAL PRIMARY KEY,
	Pest_Type VARCHAR(20) UNIQUE
);
CREATE TABLE PestDimension (
    PestId SERIAL PRIMARY KEY,
	Pest_Type VARCHAR(20),
	Timestamp TIMESTAMP,
	Pest_Description TEXT,
	Pest_Severity VARCHAR(20)
);
-- Populate the pest_type dim table
INSERT INTO PestType (Pest_Type)
SELECT DISTINCT Pest_Type FROM stage_pestdataraw;

-- Populate Pest Dimension Table
INSERT INTO PestDimension (Pest_Type, Timestamp, Pest_Description, Pest_Severity)
SELECT
    pt.Pest_Type,
    pd.Timestamp,
    pd.Pest_Description,
    pd.Pest_Severity
FROM stage_pestdataraw pd
JOIN PestType pt ON pt.Pest_Type = pd.Pest_Type;

/* 
CREATE AND POPULATE SOIL DIMENSION TABLE 
 */
-- Create Soil Dimension Table
CREATE TABLE SoilDimension (
    SoilID SERIAL PRIMARY KEY,
	Timestamp timestamp,
    Soil_Comp VARCHAR(255),
    Soil_Moisture DECIMAL(5, 2),
    Soil_PH DECIMAL(4, 2),
    Nitrogen_Level DECIMAL(5, 2),
    Phosphorus_Level DECIMAL(5, 2),
    Organic_Matter DECIMAL(5, 2)
);
-- Populate Soil Dimension Table
INSERT INTO SoilDimension (Timestamp, Soil_Comp, Soil_Moisture, Soil_PH, Nitrogen_Level, Phosphorus_Level, Organic_Matter)
SELECT DISTINCT
    Timestamp,
    Soil_Comp,
    Soil_Moisture,
    Soil_PH,
    Nitrogen_Level,
    Phosphorus_Level,
    Organic_Matter
FROM stage_soildataraw;

/* 
CREATE AND POPULATE WEATHER DIMENSION TABLE 
 */
-- Create Weather Dimension Table
CREATE TABLE WeatherDimension (
    WeatherID SERIAL PRIMARY KEY,
	Timestamp TIMESTAMP,
    Weather_Condition VARCHAR(50),
    Wind_Speed DECIMAL(5, 2),
    Precipitation DECIMAL(5, 2)
);
-- Populate Weather Dimension Table
INSERT INTO WeatherDimension (Timestamp, Weather_Condition, Wind_Speed, Precipitation)
SELECT DISTINCT
    Timestamp,
    Weather_Condition,
    Wind_Speed,
    Precipitation
FROM stage_weatherdataraw;

/* 
CREATE AND POPULATE SENSOR DIMENSION TABLE 
 */
CREATE TABLE SensorDimension (
     SensorDimensionId SERIAL PRIMARY KEY,
	Timestamp TIMESTAMP,
    Sensor_Id VARCHAR (10),
	Temperature_F DECIMAL(5, 2),
	Humidity DECIMAL(5, 2),
	Soil_Moisture DECIMAL(5, 2),
	Light_Intensity DECIMAL(8, 2),
	Battery_Level DECIMAL(8, 2)
);

INSERT INTO SensorDimension (Timestamp, Sensor_Id, Temperature_F, Humidity, Soil_Moisture, Light_Intensity, Battery_Level)
SELECT DISTINCT
    Timestamp,
    Sensor_Id,
    Temperature_F,
    Humidity,
    Soil_Moisture,
    Light_Intensity,
    Battery_Level
FROM stage_sensordataraw;


/* CREATE AND POPULATE TIME DIMENSION TABLE */
CREATE TABLE Time (
    timekey SERIAL PRIMARY KEY,
    fulldate TIMESTAMP,
    date DATE,
    day INT,
    month INT,
    quarter INT,
    year INT
);

INSERT INTO Time (FullDate, Date, Day, Month, Quarter, Year)
SELECT
    timestamp AS FullDate,
    DATE(timestamp) AS Date,
    EXTRACT(DAY FROM timestamp) AS Day,
    EXTRACT(MONTH FROM timestamp) AS Month,
    EXTRACT(QUARTER FROM timestamp) AS Quarter,
    EXTRACT(YEAR FROM timestamp) AS Year
FROM (
    SELECT timestamp FROM cropdimension
    UNION
    SELECT timestamp FROM irrigationdimension
    UNION
    SELECT timestamp FROM pestdimension
    UNION
    SELECT timestamp FROM soildimension
    UNION
    SELECT timestamp FROM weatherdimension
    UNION
    SELECT timestamp FROM sensordimension
) AS fulldate;

