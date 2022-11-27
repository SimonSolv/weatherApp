//
//  Data.swift
//  Weather
//
//  Created by Simon Pegg on 27.11.2022.
//

import Foundation

struct City: Codable {
    var name: String?
    var lat: Float?
    var lon: Float?
    var country: String?
    var local_names: LocalName?
}

struct LocalName: Codable {
    var ru: String?
}

struct CityWeather: Codable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var rain: Rain?
    var snow: Snow?
    var dt: Int?
    var sys: System?
    var timezone: Int?
    var id: Int?
    var name: String?
    var cod: Int?
}

struct Coord: Codable {
    var lon: Float?
    var lat: Float?
}

struct System: Codable {
    var type: Int?
    var id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}

struct Snow: Codable {
    var oneH: Float?
    var threeH: Float?
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
        case threeH = "3h"
    }
}

struct Rain: Codable {
    var oneH: Float?
    var threeH: Float?
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
        case threeH = "3h"
    }
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Codable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Int?
    var humidity: Int?
    var sea_level: Int?
    var grnd_level: Int?
}

struct Wind: Codable {
  var speed: Float?
  var deg: Float?
  var gust: Float?
}

struct Clouds: Codable {
  var all: Int?
}
/*
 
 https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=813fe141065e9cb880c0c124702b622b
 
 https://api.openweathermap.org/data/2.5/weather?q=moscow&appid=813fe141065e9cb880c0c124702b622b
 
 https://api.openweathermap.org/data/2.5/weather?lat=55.75&lon=37.61&appid=813fe141065e9cb880c0c124702b622b&units=metric&lang=ru */

/*
 
 {
   "coord": {
     "lon": 37.61,
     "lat": 55.75
   },
   "weather": [
     {
       "id": 804,
       "main": "Clouds",
       "description": "пасмурно",
       "icon": "04n"
     }
   ],
   "base": "stations",
   "main": {
     "temp": -3.73,
     "feels_like": -8.57,
     "temp_min": -4.69,
     "temp_max": -2.64,
     "pressure": 1037,
     "humidity": 96,
     "sea_level": 1037,
     "grnd_level": 1019
   },
   "visibility": 1052,
   "wind": {
     "speed": 3.64,
     "deg": 90,
     "gust": 9.4
   },
   "clouds": {
     "all": 100
   },
   "dt": 1669575152,
   "sys": {
     "type": 2,
     "id": 2000314,
     "country": "RU",
     "sunrise": 1669526865,
     "sunset": 1669554411
   },
   "timezone": 10800,
   "id": 524901,
   "name": "Москва",
   "cod": 200
 }
 
 */
