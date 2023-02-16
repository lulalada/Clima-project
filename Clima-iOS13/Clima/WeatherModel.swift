//
//  WeatherModel.swift
//  Clima
//
//  Created by Alua Sayabayeva on 2023-01-13.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let id: Int
    let cityName: String
    let temp: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temp)
    }
    var contitionName: String { //computed property
        var weather = ""
        switch id {
        case 0...299:
            weather = "cloud.bolt"
        case 300...399:
            weather = "cloud.drizzle"
        case 500...599:
            weather = "cloud.rain"
        case 600...699:
            weather = "cloud.snow"
        case 700...799:
            weather = "cloud.fog"
        case 800:
            weather = "sun.max"
        case 801...899:
            weather = "cloud"
        default:
            weather = "sun.max"
        }
        return weather
        
    }
    
    
}
