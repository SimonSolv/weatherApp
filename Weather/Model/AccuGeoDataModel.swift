//
//  AccuGeaDataModel.swift
//  Weather
//
//  Created by Simon Pegg on 04.12.2022.
//
import MapKit
import Foundation

struct City: Codable {
    var Key: String
    var LocalizedName: String
    var Country: CityCountry
}

struct CityCountry: Codable {
    var LocalizedName: String
    var ID: String
}


func requestGeo(city: String, completion: ((_ cities: [City]? ) -> Void)?) {
    let components = geoUrlComponents(city: city)
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
            let answer = try JSONDecoder().decode([City].self, from: data)
            completion?(answer)
            return
        } catch {
            print(error.localizedDescription)
        }
    })
    task.resume()
}



func requestCityKeyByGeoposition(position: CLLocation, completion: ((_ city: City? ) -> Void)?) {
    let components = geoKeyUrlComponents(location: position)
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
            let answer = try JSONDecoder().decode(City.self, from: data)
            completion?(answer)
            return
        } catch {
            print(error.localizedDescription)
        }
    })
    task.resume()

}

func geoUrlComponents(city: String) -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "http"
    urlComponents.host = "dataservice.accuweather.com"
    urlComponents.path = "/locations/v1/cities/search"
    urlComponents.queryItems = [
        URLQueryItem(name: "apikey", value: AccuweatherApiKey.shared.apiKey),
        URLQueryItem(name: "q", value: "\(city)"),
        URLQueryItem(name: "language", value: "ru-ru"),
        URLQueryItem(name: "details", value: "false"),
        URLQueryItem(name: "offset", value: "10")

    ]
    return urlComponents
}
///"http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=vbLNNhYHSz1nZtUIKkfsG78NZVGuzXGl&q=50.012%2C47.0112&language=ru-ru"

func geoKeyUrlComponents(location: CLLocation) -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "http"
    urlComponents.host = "dataservice.accuweather.com"
    urlComponents.path = "/locations/v1/cities/geoposition/search"
    urlComponents.queryItems = [
        URLQueryItem(name: "apikey", value: AccuweatherApiKey.shared.apiKey),
        URLQueryItem(name: "q", value: "\(location.coordinate.latitude),\(location.coordinate.longitude)"),
        URLQueryItem(name: "language", value: "ru-ru")
    ]
    return urlComponents
}
/*
 
 http://dataservice.accuweather.com/locations/v1/cities/search?apikey=vbLNNhYHSz1nZtUIKkfsG78NZVGuzXGl&q=moscow&language=en-ru&details=false&offset=2
 
 http://dataservice.accuweather.com/locations/v1/cities/search?apikey=vbLNNhYHSz1nZtUIKkfsG78NZVGuzXGl&q=%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0&language=ru-ru&details=false&offset=2
 
 */



/*
 
 
 {
   "Version": 1,
   "Key": "294021",
   "Type": "City",
   "Rank": 10,
   "LocalizedName": "Moscow",
   "EnglishName": "Moscow",
   "PrimaryPostalCode": "",
   "Region": {
     "ID": "ASI",
     "LocalizedName": "Asia",
     "EnglishName": "Asia"
   },
   "Country": {
     "ID": "RU",
     "LocalizedName": "Russia",
     "EnglishName": "Russia"
   },
   "AdministrativeArea": {
     "ID": "MOW",
     "LocalizedName": "Moscow",
     "EnglishName": "Moscow",
     "Level": 1,
     "LocalizedType": "Federal City",
     "EnglishType": "Federal City",
     "CountryID": "RU"
   },
   "TimeZone": {
     "Code": "MSK",
     "Name": "Europe/Moscow",
     "GmtOffset": 3,
     "IsDaylightSaving": false,
     "NextOffsetChange": null
   },
   "GeoPosition": {
     "Latitude": 55.752,
     "Longitude": 37.619,
     "Elevation": {
       "Metric": {
         "Value": 155,
         "Unit": "m",
         "UnitType": 5
       },
       "Imperial": {
         "Value": 508,
         "Unit": "ft",
         "UnitType": 0
       }
     }
   },
   "IsAlias": false,
   "SupplementalAdminAreas": [
     {
       "Level": 2,
       "LocalizedName": "Tsentralny",
       "EnglishName": "Tsentralny"
     }
   ],
   "DataSets": [
     "AirQualityCurrentConditions",
     "AirQualityForecasts",
     "Alerts",
     "DailyPollenForecast",
     "ForecastConfidence",
     "FutureRadar",
     "MinuteCast"
   ]
 }
 */
