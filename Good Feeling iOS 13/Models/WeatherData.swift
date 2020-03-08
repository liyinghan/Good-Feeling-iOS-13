//
//  WeatherData.swift
//  Good Feeling iOS 13
//
//  Created by han.li on 2020/3/7.
//  Copyright © 2020 jordanlake. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable {
    let temp :Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Weather: Decodable{
    let id: Int
    let main: String
    let description: String
    let icon: String
}
