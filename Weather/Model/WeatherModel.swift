//
//  WeatherModel.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

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

struct DailyWeather {
    
    struct Contents: Codable {
        let count: Int
        let forecasts: [Forecast]
        let city: City
        
        enum CodingKeys: String, CodingKey {
            case forecasts = "list"
            case city
            case count = "cnt"
        }
    }
    
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
            case info = "weather"
            case wind
            case date = "dt_txt"
            case temp = "main"
        }
    }
}


struct Info: Codable {
    let state: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case description, icon
        case state = "main"
    }
}

struct Temp: Codable {
    let curr, min, max: Double
    
    enum CodingKeys: String, CodingKey {
        case curr = "temp"
        case min = "temp_min"
        case max = "temp_max"
    }
}

struct Wind: Codable {
    let speed, deg: Double
}
