//
//  DataStyleFormatter.swift
//  Weather
//
//  Created by Simon Pegg on 04.12.2022.
//

import Foundation

func addPlusMinus(temp: Float) -> String {
    if  temp > 0 {
        return "+\(Int(temp))°"
    } else {
        return "\(Int(temp))°"
    }
}
