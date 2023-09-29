# Day 3: Additional Fact Tables and Optimization - Task 2: Documentation and Final Testing
Document the data model, including schema structure, table relationships, and data dictionary.
Conduct final testing to ensure the accuracy and consistency of the data.
Prepare the data warehouse for querying by data analysts and scientists.

# Schema Documentation
## Time (Dimension Table)
1. Fulldate
   - Data Type: TIMESTAMP
   - Unit of Measurement: None
   - Example Values:  ["2023-05-01 10:30:00", "2023-05-01 10:35:00", "2023-05-01 10:40:00"]

2. Date
   - Data Type: DATE
   - Unit of Measurement: None
   - Example Values: ["2023-05-01", "2023-05-01", "2023-05-01"]

3. Day
   - Data Type: INTEGER
   - Unit of Measurement: None
   - Example Values: ["22", "06", "05"]

3. Month
   - Data Type: INTEGER
   - Unit of Measurement: None
   - Example Values: ["09", "01", "12"]

3. Quarter
   - Data Type: INTEGER
   - Unit of Measurement: None
   - Example Values: ["1", "2", "3", "4"]

3. Year
   - Data Type: INTEGER
   - Unit of Measurement: None
   - Example Values: ["2023", "2022", "2024"]

Location Data Table (LocationDataRaw)

1. Location_Name
   - Data Type: VARCHAR(30)
   - Unit of Measurement: None
   - Description: Name or identifier of the agricultural location.
   - Example Values: ["Farm_A", "Farm_B", "Farm_C"]

2. Latitude
   - Data Type: DECIMAL(8, 6)
   - Unit of Measurement: Degrees Latitude (°)
   - Description: Latitude coordinates of the location.
   - Example Values: [42.123456, 43.789012, 41.987654]

3. Longitude
   - Data Type: DECIMAL(9, 6)
   - Unit of Measurement: Degrees Longitude (°)
   - Description: Longitude coordinates of the location.
   - Example Values: [-78.456789, -79.123456, -76.543210]

4. Elevation
   - Data Type: DECIMAL(8, 2)
   - Unit of Measurement: Meters (m)
   - Description: Elevation of the location above sea level.
   - Example Values: [250.00, 210.00, 280.00]

5. Region
   - Data Type: VARCHAR(20)
   - Unit of Measurement: None
   - Description: Geographical region where the location is situated.
   - Example Values: ["Midwest", "Northeast", "East"]


## Weather Data Table (WeatherDimension)
1. Timestamp
   - Data Type: TIMESTAMP
   - Unit of Measurement: None
   - Description: Date and time of weather data observation.
   - Example Values: ["2023-05-01 10:30:00", "2023-05-01 10:35:00", "2023-05-01 10:40:00"]

2. Precipitation
   - Data Type: DECIMAL(5, 2)
   - Unit of Measurement: Inches (in)
   - Description: Amount of precipitation in inches.
   - Example Values: [0.12, 0.05, 0.0]

3. Wind_Speed
   - Data Type: DECIMAL(5, 2)
   - Unit of Measurement: Miles per Hour (mph)
   - Description: Wind speed in miles per hour.
   - Example Values: [8.3, 5.7, 10.1]

4. Weather_Condition
   - Data Type: VARCHAR
   - Unit of Measurement: None
   - Description: Condition of the weather
   - Example Values: [Rain, Snow, Fog]


## Soil Data Table (SoilDimension)

1. Timestamp
   - Data Type: TIMESTAMP
   - Unit of Measurement: None
   - Description: Date and time when soil data was recorded.
   - Example Values: ["2023-05-01 10:30:00", "2023-05-01 10:35:00", "2023-05-01 10:40:00"]

2. Soil_Comp
   - Data Type: DECIMAL(5, 2)
   - Unit of Measurement: Percentage (%)
   - Description: Soil composition as a percentage.
   - Example Values: [32.5, 28.7, 35.2]

3. Soil_PH
   - Data Type: DECIMAL(4, 2)
   - Unit of Measurement: None
   - Description: Soil pH level.
   - Example Values: [6.8, 7.2, 6.5]

4. Soil_Moisture
   - Data Type: DECIMAL(5, 2)
   - Unit of Measurement: Percentage (%)
   - Description: Soil moisture level as a percentage.
   - Example Values: [32.5, 28.7, 35.2]

5. Nitrogen_Level
   - Data Type: DECIMAL(5, 2)
   - Unit of Measurement: None
   - Description: Level of Nitrogen on the soil.
   - Example Values: [6.8, 7.2, 6.5]

6. Phosphorus_Level
   - Data Type: DECIMAL(5, 2)
   - Unit of Measurement: None
   - Description: Level of Phosphorus on the soil.
   - Example Values: [6.8, 7.2, 6.5]

7. Organic_Matter
   - Data Type: DECIMAL(5, 2)
   - Unit of Measurement: Percentage (%)
   - Description: Organic matter in the soil
   - Example Values: [6.56, 8.75, 7.20]

## Crop Data Table (CropDimension)

1. Timestamp
   - Data Type: TIMESTAMP
   - Unit of Measurement: None
   - Description: Date and time of crop data observation.
   - Example Values: ["2023-05-01 10:30:00", "2023-05-01 10:35:00", "2023-05-01 10:40:00"]

2. Crop_Type
   - Data Type: VARCHAR(20)
   - Unit of Measurement: None
   - Description: Type of crop being monitored.
   - Example Values: ["Wheat", "Corn", "Soybeans"]

3. Crop_Yield
   - Data Type: DECIMAL(8, 2)
   - Unit of Measurement: Bushels per Acre (bu/ac)
   - Description: Crop yield in bushels per acre.
   - Example Values: [45.6, 53.2, 48.9]

4. Growth_Stage
   - Data Type: VARCHAR(20)
   - Unit of Measurement: None
   - Description: Type of crop being monitored.
   - Example Values: ["Flowering", "Seeding", "Harvesting"]

5. Pest_Issue
   - Data Type: DECIMAL(8, 2)
   - Unit of Measurement: Bushels per Acre (bu/ac)
   - Description: Crop yield in bushels per acre.
   - Example Values: [Fungus, Whiteflies, Aphids]

## Pest Data Table (PestDimension)

1. Timestamp
   - Data Type: TIMESTAMP
   - Unit of Measurement: None
   - Description: Date and time of pest data observation.
   - Example Values: ["2023-05-01 10:30:00", "2023-05-01 10:35:00", "2023-05-01 10:40:00"]

2. Pest_Type
   - Data Type: VARCHAR(20)
   - Unit of Measurement: None
   - Description: Type of pest detected.
   - Example Values: ["Aphids", "Slugs", "Whiteflies"]

3. Pest_Description
   - Data Type: TEXT
   - Unit of Measurement: None
   - Description: Description of pest-related observations.
   - Example Values: ["Aphids infestation detected.", "Slugs found in field.", "Whiteflies observed on crops."]

4. Pest_Severity
   - Data Type: TEXT
   - Unit of Measurement: None
   - Description: Severity of Pest issue.
   - Example Values: ["Low", "Medium", "High"]

## Irrigation Data Table (IrrigationDimension)

1. Timestamp
   - Data Type: TIMESTAMP
   - Unit of Measurement: None
   - Description: Date and time of irrigation data observation.
   - Example Values: ["2023-05-01 10:30:00", "2023-05-01 10:35:00", "2023-05-01 10:40:00"]

2. Irrigation_Method
   - Data Type: VARCHAR(20)
   - Unit of Measurement: None
   - Description: Method used for irrigation.
   - Example Values: ["Drip", "Sprinkler", "Flood"]

3. Water_Source
   - Data Type: VARCHAR(20)
   - Unit of Measurement: None
   - Description: Source of irrigation water.
   - Example Values: ["Well", "River", "Pond"]

4. Irrigation_Duration_Min
   - Data Type: INTEGER
   - Unit of Measurement: None
   - Description: Irrigation duration in minutes.
   - Example Values: ["29", "10", "45"]
   


