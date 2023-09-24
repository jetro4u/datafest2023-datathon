/* ## Day 3: Additional Fact Tables and Optimization

Task 1: Indexing and Optimization
Implement appropriate indexing strategies to optimize query performance.
Analyze the query patterns and optimize the data model accordingly.
Perform data quality checks and address any anomalies.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task3.sql).
*/
-- Add indexes to CropTypeId columns in both tables
CREATE INDEX idx_CropType_CropTypeId ON CropType (CropTypeId);
CREATE INDEX idx_CropDimension_CropId ON CropDimension (CropId);
CREATE INDEX idx_CropDimension_CropType ON CropDimension (Crop_Type);

-- Index on LocationID (Primary Key)
CREATE INDEX idx_Location_LocationID
ON Location(LocationID);

-- Index on Sensor_ID (if needed)
CREATE INDEX idx_Location_Sensor_ID ON Location(Sensor_ID);
-- Index on Sensor_ID (if needed)
CREATE INDEX idx_Location_Sensor_Type ON Location(Sensor_Type);

-- Create an index on the Sensor_ID column for faster searches
CREATE INDEX idx_Irrigation_Sensor_Id ON IrrigationDimension (Sensor_ID);
CREATE INDEX idx_IrrigationDimension_Sensor_Type ON IrrigationDimension (Sensor_Type);

-- Create an index on the Timestamp column for faster time-based queries
CREATE INDEX idx_timestamp ON IrrigationDimension (Timestamp);

CREATE INDEX idx_PestType_Pest_Type ON PestType (Pest_Type);
CREATE INDEX idx_PestDimension_Pest_Type ON PestDimension (Pest_Type);

-- Create an index on the Timestamp column in SoilDimension table
CREATE INDEX idx_soil_timestamp ON SoilDimension (Timestamp);

CREATE INDEX idx_weather_condition ON WeatherDimension (Weather_Condition);

CREATE INDEX idx_Sensor_Id ON SensorDimension(Sensor_Id);
