//
//  HourlyDataModel.swift
//  Weather
//
//  Created by Simon Pegg on 28.11.2022.
//

import Foundation

struct HourlyWeather: Codable {
    var list: [HourlyList]
}

struct HourlyList: Codable {
    var dt: Int
    var main: [HourlyMain] //температура, ощущается, макс/мин, давление, влажность,
    var weather: [HourlyDescription]
    var clouds: HourlyClouds //процент облаков
    var wind: HourlyWind //скорость и направление ветра
    var rain: HourlyRain? //выпало дождя за последний час
    var snow: HourlySnow? //выпало снега за последний час
    var pop: Float //вероятность осадков
    var dt_txt: String //дата и время строкой
    var sunrise: Int? //восход
    var sunSet: Int? //закат
}

struct HourlyMain: Codable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Int
    var humidity: Int

}

struct HourlyDescription: Codable {
    var description: String
    var id: Int
}

struct HourlyClouds: Codable {
    var all: Int
}

struct HourlyWind: Codable {
    var speed: Float
    var deg: Int
}

struct HourlySnow: Codable {
    var oneH: Float
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}

struct HourlyRain: Codable {
    var oneH: Float
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}
/*
 https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=57&lon=-2.15&appid=21f4736ce7781dd9c5e1d4e98534fdb9&lang=ru

*/

private func hourlyWeatherUrlComponents(city: City) -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "pro.openweathermap.org"
    urlComponents.path = "/data/2.5/forecast/hourly"
    urlComponents.queryItems = [
        URLQueryItem(name: "lat", value: "40"),
        URLQueryItem(name: "lon", value: "20"),
        URLQueryItem(name: "appid", value: WeatherApiKey.shared.apiKey),
//        URLQueryItem(name: "units", value: "metric"),
//        URLQueryItem(name: "lang", value: "ru")
    ]
    return urlComponents
}

func requestHourlyWeather(city: City, completion: ((_ weather: HourlyWeather? ) -> Void)?) {
    let components = hourlyWeatherUrlComponents(city: city)
    let url = components.url
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url!, completionHandler: { data, responce, error in
        if let error = error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }
        
        if (responce as! HTTPURLResponse).statusCode != 200 {
            print ("StstusCode = \((responce as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }
        
        guard let data = data else {
            print("No data received")
            completion?(nil)
            return
        }
        
        do {
            let answer = try JSONDecoder().decode(HourlyWeather.self, from: data)
            completion?(answer)
            return
        } catch {
            print(error)
        }
    })
    task.resume()
}
