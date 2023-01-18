//
//  Data.swift
//  Weather
//
//  Created by Simon Pegg on 27.11.2022.
//

import Foundation

enum WeatherDataType {
    case cityWeather
    case dailyWeather16
    case geo
    case hourlyWeather
}

struct CityWeather: Codable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main
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
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Int
    var humidity: Int
    var sea_level: Int?
    var grnd_level: Int?
}

//struct Wind: Codable {
//  var speed: Float?
//  var deg: Float?
//  var gust: Float?
//}

struct Clouds: Codable {
  var all: Int?
}

//func decodeDataFromJson(data: Data?, type: WeatherDataType, completion: ((_ decodeResult: Any?) -> Void)?) {
//    guard data != nil else {
//        print("No data received")
//        completion?(nil)
//        return
//    }
//    switch type {
//    case .cityWeather:
//        do {
//            let answer = try JSONDecoder().decode(CityWeather.self, from: data!)
//            completion?(answer)
//            return
//        } catch {
//            print(error)
//        }
//    case .geo:
//        do {
//            let answer = try JSONDecoder().decode([City].self, from: data!)
//            completion?(answer)
//            return
//        } catch {
//            print(error)
//        }
//    case .dailyWeather16:
//        do {
//            let answer = try JSONDecoder().decode(CityWeather.self, from: data!)
//            completion?(answer)
//            return
//        } catch {
//            print(error)
//        }
//    case .hourlyWeather:
//        do {
//            let answer = try JSONDecoder().decode(HourlyWeather.self, from: data!)
//            completion?(answer)
//            return
//        } catch {
//            print(error)
//        }
//    }
//}
//
//func requestWeatherData(city: City, type: WeatherDataType, completion: ((_ answer: Any?) -> Void)?) {
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
//            var answer: Any? = nil
//            decodeDataFromJson(data: data, type: type) { result in
//                answer = result
//            }
//            completion?(answer)
//            return
//        } catch {
//            print(error)
//        }
//
//    })
//    task.resume()
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



