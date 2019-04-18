//
//  WeatherModel.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    struct Info: Codable {
        let weather: [Weather]
        let main: Main
        let wind: Wind
        let dt: Int
        let cityID: Int
        let city: String
        
        enum CodingKeys: String, CodingKey {
            case weather
            case main, wind
            case dt
            case cityID = "id"
            case city = "name"
        }
    }
    
    struct Main: Codable {
        let temp: Double
        let tempMin, tempMax: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    
    struct Weather: Codable {
        let id: Int
        let main, description, icon: String
    }
    
    struct Wind: Codable {
        let speed, deg: Double
    }
}
