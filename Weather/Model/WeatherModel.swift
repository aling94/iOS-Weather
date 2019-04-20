//
//  WeatherModel.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

// MARK: - Main Weather Models

struct CurrentWeather: Codable {
    let info: [Info]
    let temp: Temp
    let wind: Wind
    let time: Int
    let cityID: Int
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case info = "weather"
        case temp = "main"
        case wind
        case time = "dt"
        case cityID = "id"
        case city = "name"
    }
}

struct WeatherList: Codable {
    let cities: [CurrentWeather]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case cities = "list"
    }
}

struct DailyWeather: Codable {
    
    let count: Int
    let forecasts: [Forecast]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case forecasts = "list"
        case city
    }
    
    subscript(index: Int) -> Forecast {
        return forecasts[index]
    }
}

// MARK: - Weather Info Structs

struct City: Codable {
    let id: Int
    let name: String
    let country: String
}

struct Forecast: Codable {
    let time: Int
    let temp: Temp
    let info: [Info]
    let wind: Wind
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case temp = "main"
        case info = "weather"
        case wind
        case date = "dt_txt"
    }
}

struct Info: Codable {
    let state: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        
        case state = "main"
        case description, icon
    }
}

struct Temp: Codable {
    let curr, min, max: Double
    var metric: Bool! = true
    
    var current: String {
        return String(format: "%.0f\(unit)", metric ? curr : curr.fahrenheit)
    }
    
    var high: String {
        return String(format: "%.0f\(unit)", metric ? max : max.fahrenheit)
    }
    
    var low: String {
        return String(format: "%.0f\(unit)", metric ? min : min.fahrenheit)
    }
    
    var highLow: String {
        return metric ? String(format: "%.0f/%.0f\(unit)", max, min) :
            String(format: "%.0f/%.0f\(unit)", max.fahrenheit, min.fahrenheit)
    }
    
    var unit: String {
        return metric ? "° C" : "° F"
    }
    
    enum CodingKeys: String, CodingKey {
        case curr = "temp"
        case min = "temp_min"
        case max = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double
    var metric: Bool! = true
    
    var spd: String {
        return String(format: "%.2f \(unit)", metric ? speed : speed.mph)
    }
    
    var unit: String {
        return metric ? "m/s" : "mph"
    }
    
    enum CodingKeys: String, CodingKey {
        case speed
    }
}
