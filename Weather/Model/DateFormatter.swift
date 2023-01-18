//
//  DateFormatter.swift
//  Weather
//
//  Created by Simon Pegg on 04.12.2022.
//

import Foundation

func timeToString(time: Int, type: DateTimeType, timeZone: Int?) -> String? {
    let date = Date(timeIntervalSince1970: Double(time))
    let dateFormatter = DateFormatter()
    if timeZone != nil {
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone!)
    } else {
        dateFormatter.timeZone = TimeZone.current
    }
    dateFormatter.locale = Locale(identifier: "ru_RU")
    var localDate = ""
    switch type {
    case .time:
        dateFormatter.dateFormat = "HH:MM" //Set time style
        localDate = dateFormatter.string(from: date)
    case .dateTime:
        dateFormatter.dateFormat = "HH:MM, EEEE d MMMM" //Set date style
        localDate = dateFormatter.string(from: date)
    }
    return localDate
}

enum DateTimeType {
    case time
    case dateTime
}
