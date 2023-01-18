//
//  AccuDayDataModel.swift
//  Weather
//
//  Created by Simon Pegg on 06.12.2022.
//

import Foundation

struct Answer: Codable {
    var result: [CurrentWeather]
}

struct HourWeather: Codable {
    var localTime: String
    var time: Int
    var icon: Int
    var description: String
    var precipitation: Bool
    var temp: MetricImperialValue
    enum CodingKeys: String, CodingKey {
        case localTime = "DateTime"
        case time = "EpochDateTime"
        case icon = "WeatherIcon"
        case description = "IconPhrase"
        case precipitation = "HasPrecipitation"
        case temp = "Temperature"
    }
}

struct CurrentWeather: Codable {
    var localTime: String
    var time: Int //время в кодировке сейчас
    var description: String // описание погоды сейчас
    var temp: MetricImperialType //температура сейчас
    var feelsLike: MetricImperialType //ощущается
    var humidity: Int //влажность
    var isDayTime: Bool // сейчас день?
    var wind: Wind // ветер и направление ветра
    var clouds: Int //облачность
    var precipitation: MetricImperialType//осадки
    var minMaxTemp: TemperatureSummary
    enum CodingKeys: String, CodingKey {
        case time = "EpochTime"
        case description = "WeatherText"
        case temp = "Temperature"
        case feelsLike = "RealFeelTemperature"
        case humidity = "RelativeHumidity"
        case isDayTime = "IsDayTime"
        case wind = "Wind"
        case clouds = "CloudCover"
        case precipitation = "Precip1hr"
        case minMaxTemp = "TemperatureSummary"
        case localTime = "LocalObservationDateTime"
    }
}

struct TemperatureSummary: Codable {
    var past12Hours: Past12HourRange
    enum CodingKeys: String, CodingKey {
        case past12Hours = "Past12HourRange"
    }
}

struct Past12HourRange: Codable {
    var min: MetricImperialType
    var max: MetricImperialType
    enum CodingKeys: String, CodingKey {
        case min = "Minimum"
        case max = "Maximum"
    }
}

struct MetricImperialType: Codable {
    var metric: MetricImperialValue
    var imperial: MetricImperialValue
    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

struct MetricImperialValue: Codable {
    var value: Float // значение градусов со знаком
    var unit: String //цельсий или фаренгейт
    var description: String? //описание погоды
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case description = "Phrase"
    }
}

private func dayWeatherUrlComponents(city: String) -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "http"
    urlComponents.host = "dataservice.accuweather.com"
    urlComponents.path = "/currentconditions/v1/" + city
    urlComponents.queryItems = [
        URLQueryItem(name: "apikey", value: AccuweatherApiKey.shared.apiKey),
        URLQueryItem(name: "language", value: "ru-ru"),
        URLQueryItem(name: "details", value: "true"),
      //  URLQueryItem(name: "metric", value: "true")
    ]
    return urlComponents
}
/*
 http://dataservice.accuweather.com/currentconditions/v1/294021?apikey=vbLNNhYHSz1nZtUIKkfsG78NZVGuzXGl&language=ru-ru&details=true
 
 */
func requestDayWeather(city: String, completion: ((_ weather: [CurrentWeather]? ) -> Void)?) {
    let components = dayWeatherUrlComponents(city: city)
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
            let answer = try JSONDecoder().decode([CurrentWeather].self, from: data)
            completion?(answer)
            return
        } catch {
            print(error)
        }
    })
    task.resume()
}

private func hourWeatherUrlComponents(city: String) -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "http"
    urlComponents.host = "dataservice.accuweather.com"
    urlComponents.path = "/forecasts/v1/hourly/12hour/" + city
    urlComponents.queryItems = [
        URLQueryItem(name: "apikey", value: AccuweatherApiKey.shared.apiKey),
        URLQueryItem(name: "language", value: "ru-ru"),
       // URLQueryItem(name: "details", value: "true"),
        URLQueryItem(name: "metric", value: "true")
    ]
    return urlComponents
}

/*
 
 http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/294021?apikey=vbLNNhYHSz1nZtUIKkfsG78NZVGuzXGl&language=ru-ru&metric=true
 
 */

func requestHourWeather(city: String, completion: ((_ weather: [HourWeather]? ) -> Void)?) {
    let components = hourWeatherUrlComponents(city: city)
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
            let answer = try JSONDecoder().decode([HourWeather].self, from: data)
            completion?(answer)
            return
        } catch {
            print(error)
        }
    })
    task.resume()
}
