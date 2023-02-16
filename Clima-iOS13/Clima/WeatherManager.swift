//
//  WeatherManager.swift
//  Clima
//
//  Created by Alua Sayabayeva on 2023-01-13.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManger, weather: WeatherModel)
    func didFailWithError(error: Error) 
}


struct WeatherManger {
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=9d3f0b6778082e43b82f29aaa58314b9&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        // Networking steps
        //1. creating url
        if let url = URL(string: urlString) {
            //2. create url session
            let session = URLSession(configuration: .default)
            //3. give a session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        /*let weatherVC = WeatherViewController()
                        weatherVC.didUpdateWeather(weather: weather)*/
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. start the task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id =  decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(id: id, cityName: name, temp: temp)
            
            return weather
            print(weather.contitionName)
            print(weather.temperatureString)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
