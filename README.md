[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

Dataset created with [trip-simulator](https://github.com/sharedstreets/trip-simulator).

## Description

Data in [GeoJSON](https://geojson.org/) format.

50 bikes, 150 scooters. Around 143,000 trips per month. All trips from 7am to midnight every day.

An example: https://gist.github.com/adolfosilva/509afdbb2fe1154a41d14d1273742fca

## Example

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "LineString",
      "coordinates": [
        [-8.42181198667037, 41.54897782193805],
        [-8.421663131491517, 41.54905996048945],
        [-8.42167291796564, 41.549059169652686],
        [-8.422031208158675, 41.54934055068267],
        [-8.42203024486226, 41.549610428722595]
      ],
      "properties": {
          "vehicle_id": "OOY-7429",
          "vehicle_type": "scooter",
          "trip_duration": 150.09608423876423,
          "trip_distance": 186.24907199695616,
          "start_time": 2802400,
          "end_time": 2952496.0842387644,
          "timestamps": [
             { "timestamp": 2802400 },
             { "timestamp": 2803400 },
             { "timestamp": 2805400 },
             { "timestamp": 2805400 },
             { "timestamp": 2805400 }
          ]
      }
    }
  ]
}
```

## Schema

```json
{
  "type": "object",
  "required": [],
  "properties": {
    "type": {
      "type": "string"
    },
    "features": {
      "type": "array",
      "items": {
        "type": "object",
        "required": [],
        "properties": {
          "type": {
            "type": "string"
          },
          "coordinates": {
            "type": "array",
            "items": {
              "type": "array",
              "items": {
                "type": "number"
              }
            }
          },
          "properties": {
            "type": "array",
            "items": {
              "type": "object",
              "required": [],
              "properties": {
                "timestamp": {
                  "type": "number"
                }
              }
            }
          }
        }
      }
    }
  }
}
```
