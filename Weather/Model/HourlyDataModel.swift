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
    var main: [HourlyMain]
    var weather: [HourlyDescription] //температура, ощущается, макс/мин, давление, влажность,
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

