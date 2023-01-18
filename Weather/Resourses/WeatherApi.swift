//
//  WeatherApi.swift
//  Weather
//
//  Created by Simon Pegg on 01.12.2022.
//

import Foundation

struct WeatherApiKey {
    static let shared = WeatherApiKey()
    
  //  let apiKey = "21f4736ce7781dd9c
    //5e1d4e98534fdb9"
    
    let apiKey = "76c5dd79aaba000000000000000e3795304afae60046e31"
    
    private init() { }
}

struct AccuweatherApiKey {
    static let shared = AccuweatherApiKey()


    let apiKey: String = {
        let firstApi = "vbLNNhYHSz1nZt"
        let secondApi = "UIKkfsG78NZVGuzXGl"
        return firstApi + secondApi
    }()
    
    private init() { }
}

