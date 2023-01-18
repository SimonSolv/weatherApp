//
//  AccuWeatherDataModel.swift
//  Weather
//
//  Created by Simon Pegg on 06.12.2022.
//

import Foundation

struct DayWeather: Codable {
    var dailyWeather: [Daily]
    var day: DayNightDescription
    var night: DayNightDescription
    
    enum CodingKeys: String, CodingKey {
        case dailyWeather = "DailyForecasts"
        case day = "Day"
        case night = "Night"
    }
}

struct Daily: Codable {
    var date: Int
    var sun: RiseSet
    var moon: RiseSet
    var temp: MinMax
    var feels: MinMax
    var airConditions: [AirConditions]

    enum CodingKeys: String, CodingKey {
        case date = "EpochDate"
        case sun = "Sun"
        case moon = "Moon"
        case temp = "Temperature"
        case feels = "RealFeelTemperature"
        case airConditions = "AirAndPollen"

    }
}

struct RiseSet: Codable {
    var tRise: Int
    var tSet: Int
    
    enum CodingKeys: String, CodingKey {
        case tRise = "EpochRise"
        case tSet = "EpochSet"
    }
}

struct MinMax: Codable {
    var min: Temperature
    var max: Temperature
    
    enum CodingKeys: String, CodingKey {
        case min = "Minimum"
        case max = "Maximum"
    }
}

struct Temperature: Codable {
    var temp: Int
    var unit: String
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case temp = "Value"
        case unit = "Unit"
        case description = "Phrase"
    }
}

struct AirConditions: Codable {
    var name: String
    var description: String
    var optionalDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Category"
        case optionalDescription = "Type"
    }
}

struct DayNightDescription: Codable {
    var weatherDescription: String
    var perceptionProbability: Int
    var rainProbability: Int
    var snowProbability: Int
    var wind: Wind
    var perceptions: Perception
    var rain: Perception
    var snow: Perception
    var ice: Perception
    var clouds: Int
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "ShortPhrase"
        case wind = "Wind"
        case perceptionProbability = "PrecipitationProbability"
        case rainProbability = "RainProbability"
        case snowProbability = "SnowProbability"
        case perceptions = "TotalLiquid"
        case rain = "Rain"
        case snow = "Snow"
        case ice = "Ice"
        case clouds = "CloudCover"
    }
}

struct Perception: Codable {
    var value: Int
    var unit: String
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"

    }
}

struct Wind: Codable {
    var speed: MetricImperialType
    var direction: WindDirection
    
    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}

struct WindSpeed: Codable {
    var value: Int
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}

struct WindDirection: Codable {
    var value: Int
    var direction: String
    
    enum CodingKeys: String, CodingKey {
        case value = "Degrees"
        case direction = "Localized"
    }
}

struct CurrentDayWeather: Codable {
    
}

/*
{
  "Headline": {
    "EffectiveDate": "2022-12-10T01:00:00+03:00",
    "EffectiveEpochDate": 1670623200,
    "Severity": 3,
    "Text": "Пятница, поздняя ночь: небольшая изморозь",
    "Category": "snow",
    "EndDate": "2022-12-10T07:00:00+03:00",
    "EndEpochDate": 1670644800,
    "MobileLink": "http://www.accuweather.com/ru/ru/moscow/294021/daily-weather-forecast/294021?unit=c",
    "Link": "http://www.accuweather.com/ru/ru/moscow/294021/daily-weather-forecast/294021?unit=c"
  },
  "DailyForecasts": [
    {
      "Date": "2022-12-06T07:00:00+03:00",
      "EpochDate": 1670299200,
      "Sun": {
        "Rise": "2022-12-06T08:42:00+03:00",
        "EpochRise": 1670305320,
        "Set": "2022-12-06T15:59:00+03:00",
        "EpochSet": 1670331540
      },
      "Moon": {
        "Rise": "2022-12-06T14:50:00+03:00",
        "EpochRise": 1670327400,
        "Set": "2022-12-07T08:05:00+03:00",
        "EpochSet": 1670389500,
        "Phase": "WaxingGibbous",
        "Age": 12
      },
      "Temperature": {
        "Minimum": {
          "Value": -12.2,
          "Unit": "C",
          "UnitType": 17
        },
        "Maximum": {
          "Value": -5,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "RealFeelTemperature": {
        "Minimum": {
          "Value": -16.1,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Ужасный холод"
        },
        "Maximum": {
          "Value": -10.6,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Очень холодно"
        }
      },
      "RealFeelTemperatureShade": {
        "Minimum": {
          "Value": -16.1,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Ужасный холод"
        },
        "Maximum": {
          "Value": -10.6,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Очень холодно"
        }
      },
      "HoursOfSun": 6.1,
      "DegreeDaySummary": {
        "Heating": {
          "Value": 27,
          "Unit": "C",
          "UnitType": 17
        },
        "Cooling": {
          "Value": 0,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "AirAndPollen": [
        {
          "Name": "AirQuality",
          "Value": 0,
          "Category": "Хорошая",
          "CategoryValue": 1,
          "Type": "Озон"
        },
        {
          "Name": "Grass",
          "Value": 0,
          "Category": "Низк.",
          "CategoryValue": 1
        },
        {
          "Name": "Mold",
          "Value": 0,
          "Category": "Низк.",
          "CategoryValue": 1
        },
        {
          "Name": "Tree",
          "Value": 0,
          "Category": "Низк.",
          "CategoryValue": 1
        },
        {
          "Name": "Ragweed",
          "Value": 0,
          "Category": "Низк.",
          "CategoryValue": 1
        },
        {
          "Name": "UVIndex",
          "Value": 1,
          "Category": "Низк.",
          "CategoryValue": 1
        }
      ],
      "Day": {
        "Icon": 4,
        "IconPhrase": "Переменная облачность",
        "HasPrecipitation": false,
        "ShortPhrase": "Облачно, затем прояснится",
        "LongPhrase": "Облачно, затем прояснится",
        "PrecipitationProbability": 1,
        "ThunderstormProbability": 0,
        "RainProbability": 0,
        "SnowProbability": 1,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 14.5,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 187,
            "Localized": "Ю",
            "English": "S"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 25.7,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 187,
            "Localized": "Ю",
            "English": "S"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 25,
        "Evapotranspiration": {
          "Value": 0.3,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 1454.6,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Night": {
        "Icon": 35,
        "IconPhrase": "Облачно с прояснениями",
        "HasPrecipitation": false,
        "ShortPhrase": "Облачно с прояснениями",
        "LongPhrase": "Облачно с прояснениями",
        "PrecipitationProbability": 1,
        "ThunderstormProbability": 0,
        "RainProbability": 0,
        "SnowProbability": 1,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 14.5,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 176,
            "Localized": "Ю",
            "English": "S"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 27.4,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 176,
            "Localized": "Ю",
            "English": "S"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 48,
        "Evapotranspiration": {
          "Value": 0.3,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 0,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Sources": [
        "AccuWeather"
      ],
      "MobileLink": "http://www.accuweather.com/ru/ru/moscow/294021/daily-weather-forecast/294021?day=1&unit=c",
      "Link": "http://www.accuweather.com/ru/ru/moscow/294021/daily-weather-forecast/294021?day=1&unit=c"
    }
  ]
}
*/




/*
 
 "http://dataservice.accuweather.com/forecasts/v1/daily/1day/294021?apikey=vbLNNhYHSz1nZtUIKkfsG78NZVGuzXGl&language=ru-ru&details=true&metric=true"
 */



