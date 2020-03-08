//
//  WeatherManager.swift
//  Good Feeling iOS 13
//
//  Created by han.li on 2020/3/7.
//  Copyright © 2020 jordanlake. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather:WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    //    let cityName: String
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5b6f7197d46d2c45d8c419fc00f5ff8e&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    // fetch weather by city name
    func fetchWeather(cityName: String) {
        
        // replace space for city names contains space, ie. san francisco
        //http://api.openweathermap.org/data/2.5/weather?q=san%20Francisco&appid=5b6f7197d46d2c45d8c419fc00f5ff8e
        let replacedName = cityName.replacingOccurrences(of: " ", with: "%20")
        //        print(replacedName)
        
        let urlString = "\(weatherURL)&q=\(replacedName)"
        // call performRequest to get the weather data
        performRequest(with: urlString)
    }
    
    // featch weather by coordinate
    func fetchWeather(latitue: CLLocationDegrees, longitude:  CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitue)&lon=\(longitude)"
        // call performRequest to get the weather data
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String){
        
        // create a url by using URL initializer
        
        if let url = URL(string: urlString) {
            
            // create a url session
            let session = URLSession(configuration: .default)
            
            // give url session a task
            
            let task = session.dataTask(with: url) { (data, reponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //                    let dataString = String(data: safeData, encoding: .utf8)
                    //                    print(dataString)
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //start the task
            task.resume()
        }
    }// end of performRequest
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            //            print(decodeData.weather[0].description)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let humidity = decodeData.main.humidity
            let pressure = decodeData.main.pressure
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, airHumidity: humidity, airPressure: pressure)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
} //  end of struct WeatherManager
