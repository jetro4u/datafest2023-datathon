/* From the Output of a Query:
You can also use the COPY command to insert data into a table from the output of a query. 
*/
COPY (
    SELECT 
    td.fulldate AS timestamp,
    td.date AS date,
    sd.Soil_Comp AS soilcomp,
    sd.Soil_Moisture AS soilmoisture,
    sd.Soil_PH AS soilph,
    sd.Nitrogen_Level AS nitrogenlevel,
    sd.Phosphorus_Level AS phosphoruslevel,
    sd.Organic_Matter AS organicmatter,
    cd.Crop_Type AS croptype,
    cd.Growth_Stage AS growthstage,
    cd.Pest_Issue AS pestissue,
    cd.Crop_yield AS cropyield,
    se.Temperature_F AS temperature,
    se.Humidity AS humidity,
    se.Light_Intensity AS lightintensity,
    se.Soil_Moisture AS sensorsoilmoisture,
    ir.Irrigation_Method AS irrigationmethod,
    ir.Water_Source AS watersource,
    ir.Irrigation_Duration_Min AS irrigationdurationmin,
    we.Weather_Condition AS weathercondition,
    we.Wind_Speed AS windspeed,
    we.Precipitation AS precipitation
FROM Time td
LEFT JOIN SoilDimension sd ON sd.timestamp = td.fulldate
LEFT OUTER JOIN CropDimension cd ON cd.timestamp = td.fulldate
LEFT OUTER JOIN SensorDimension se ON se.timestamp = td.fulldate
LEFT OUTER JOIN IrrigationDimension ir ON ir.timestamp = td.fulldate
LEFT OUTER JOIN WeatherDimension we ON we.timestamp = td.fulldate
ORDER BY td.fulldate ASC
) TO STDOUT With CSV DELIMITER ',' HEADER \g /tmp/Soil_Facts.csv