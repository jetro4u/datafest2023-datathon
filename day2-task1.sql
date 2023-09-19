/*** INSTRUCTION 
Task 1: Create Dimension Tables
Based on the cleaned and transformed data, create dimension Tables for 
attributes such as Location, Time, Crop Type, Pest Type, and Irrigation
 Method.
Populate these dimension tables.
***/

/* CREATE DIMENSION TABLES */
CREATE TABLE sensor (
	id VARCHAR (10) PRIMARY KEY
);
CREATE TABLE time (
    id SERIAL PRIMARY KEY,
	time timestamp,
    period date
);
CREATE TABLE location (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR (30),
	sensorid VARCHAR (10),
    latitude DECIMAL(8, 6),
    longitude DECIMAL(9, 6),
    elevation DECIMAL(8, 2),
    region VARCHAR (20)
);
CREATE TABLE irrigationmethod (
    id SERIAL PRIMARY KEY,
	time timestamp,
	name VARCHAR(20)
);
CREATE TABLE watersource (
    id SERIAL PRIMARY KEY,
	time timestamp,
	name VARCHAR(20)
);
CREATE TABLE croptype (
    id SERIAL PRIMARY KEY,
	time timestamp,
	name VARCHAR(20)
);
CREATE TABLE growthstage (
    id SERIAL PRIMARY KEY,
	time timestamp,
	name VARCHAR(50)
);
CREATE TABLE pesttype (
    id SERIAL PRIMARY KEY,
	time timestamp,
	name VARCHAR(20)
);
ALTER TABLE location ADD CONSTRAINT fk_sensor
 FOREIGN KEY (sensorid) REFERENCES sensor(id);

/* POPULATE DIMENSION DATA */
INSERT INTO sensor (id)
SELECT DISTINCT sensorid FROM stage_sensordata;

INSERT INTO time (time)
SELECT distinct timestamp FROM stage_cropdata
UNION
SELECT distinct timestamp FROM stage_irrigationdata
UNION
SELECT distinct timestamp FROM stage_pestdata
UNION
SELECT distinct timestamp FROM stage_soildata
UNION
SELECT distinct timestamp FROM stage_weatherdata
UNION
SELECT distinct timestamp FROM stage_sensordata;

UPDATE time
SET period = DATE(time);

/* SQL query to append string to 
duplicate column value in location table */
INSERT INTO location (name, sensorid, latitude, longitude, elevation, region)
with tab as (
SELECT locationname, sensorid, latitude, longitude, elevation, region, 
       ROW_NUMBER() OVER(PARTITION BY locationname ORDER BY sensorid) As no
FROM stage_locationdata
)

SELECT 
  locationname || 
  case when no = 1 then '_A' 
  when no = 2 then '_B' else '_C' 
  end as name, 
  sensorid, latitude, longitude, elevation, region
FROM tab;

INSERT INTO irrigationmethod (name, time)
    SELECT irrigationmethod, timestamp
    FROM stage_irrigationdata 
    WHERE irrigationmethod is not null;


INSERT INTO watersource (name, time)
    SELECT watersource, timestamp 
    FROM stage_irrigationdata 
    WHERE watersource is not null;

INSERT INTO croptype (name, time)
    SELECT croptype, timestamp 
    FROM stage_cropdata 
    WHERE croptype is not null;

INSERT INTO growthstage (name, time)
    SELECT growthstage, timestamp 
    FROM stage_cropdata 
    WHERE growthstage is not null;

INSERT INTO pesttype (name, time)
    SELECT pesttype, timestamp 
    FROM stage_pestdata 
    WHERE pesttype is not null;

