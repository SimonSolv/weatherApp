//
//  RapidApi.swift
//  Weather
//
//  Created by Simon Pegg on 04.12.2022.
//


import Foundation

//struct DayWeather: Codable {
//    var DailyForecasts: [Daily]
//}
//
//struct Daily: Codable {
//    var date: Int
//    var sun: RiseSet
//    var moon: RiseSet
//    var temp: MinMax
//    var feels: MinMax
//    var airConditions: [AirConditions]
//    var day: DayNightDescription
//    var night: DayNightDescription
//    enum CodingKeys: String, CodingKey {
//        case date = "EpochDate"
//        case sun = "Sun"
//        case moon = "Moon"
//        case temp = "Temperature"
//        case feels = "RealFeelTemperature"
//        case airConditions = "AirAndPollen"
//        case day = "Day"
//        case night = "Night"
//    }
//}
//
//struct RiseSet: Codable {
//    var tRise: Int
//    var tSet: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case tRise = "EpochRise"
//        case tSet = "EpochSet"
//    }
//}
//
//struct MinMax: Codable {
//    var min: Temperature
//    var max: Temperature
//    
//    enum CodingKeys: String, CodingKey {
//        case min = "Minimum"
//        case max = "Maximum"
//    }
//}
//
//struct Temperature: Codable {
//    var temp: Int
//    var unit: String
//    var description: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case temp = "Value"
//        case unit = "Unit"
//        case description = "Phrase"
//    }
//}
//
//struct AirConditions: Codable {
//    var name: String
//    var description: String
//    var optionalDescription: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "Name"
//        case description = "Category"
//        case optionalDescription = "Type"
//    }
//}
//
//struct DayNightDescription: Codable {
//    var weatherDescription: String
//    var wind: Wind
//    
//    enum CodingKeys: String, CodingKey {
//        case weatherDescription = "ShortPhrase"
//        case wind = "Wind"
//    }
//}
//
//struct Wind: Codable {
//    var speed: WindSpeed
//    var direction: WindDirection
//    
//    enum CodingKeys: String, CodingKey {
//        case speed = "Speed"
//        case direction = "Direction"
//    }
//}
//
//struct WindSpeed: Codable {
//    var speed: Int
//    var unit: String
//    
//    enum CodingKeys: String, CodingKey {
//        case speed = "Value"
//        case unit = "Unit"
//    }
//}
//
//struct WindDirection: Codable {
//    var degrees: Int
//    var direction: String
//    
//    enum CodingKeys: String, CodingKey {
//        case degrees = "Degrees"
//        case direction = "Localized"
//    }
//}

//func requestDayWeather(city: City, completion: ((_ weather: CityWeather? ) -> Void)?) {
//    let components = dayWeatherUrlComponents(city: city)
//    let url = components.url
//    let session = URLSession(configuration: .default)
//    let task = session.dataTask(with: url!, completionHandler: { data, responce, error in
//        if let error = error {
//            print(error.localizedDescription)
//            completion?(nil)
//            return
//        }
//        
//        if (responce as! HTTPURLResponse).statusCode != 200 {
//            print ("StstusCode = \((responce as! HTTPURLResponse).statusCode)")
//            completion?(nil)
//            return
//        }
//        
//        guard let data = data else {
//            print("No data received")
//            completion?(nil)
//            return
//        }
//        
//        do {
//            let answer = try JSONDecoder().decode(CityWeather.self, from: data)
//            completion?(answer)
//            return
//        } catch {
//            print(error)
//        }
//    })
//    task.resume()
//}

/*
 
 "http://dataservice.accuweather.com/forecasts/v1/daily/1day/294021?apikey=vbLNNhYHSz1nZtUIKkfsG78NZVGuzXGl&language=ru-ru&details=true&metric=true"
 
 
 {
,
   "DailyForecasts": [
     {
        "Day": {
         "Icon": 2,
         "IconPhrase": "Преимущественно ясно",
         "HasPrecipitation": false,
         "ShortPhrase": "Преимущественно ясно",
         "LongPhrase": "Преимущественно ясно",
         "PrecipitationProbability": 2,
         "ThunderstormProbability": 0,
         "RainProbability": 0,
         "SnowProbability": 2,
         "IceProbability": 0,
,
,
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
         "CloudCover": 15,
         "Evapotranspiration": {
           "Value": 0.3,
           "Unit": "mm",
           "UnitType": 3
         },
         "SolarIrradiance": {
           "Value": 1502.9,
           "Unit": "W/m²",
           "UnitType": 33
         }
       },

   
 */
