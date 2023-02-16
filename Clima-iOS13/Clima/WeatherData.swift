//
//  WeatherData.swift
//  Clima
//
//  Created by Alua Sayabayeva on 2023-01-13.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    
}
struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let id: Int
}
