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
    
    var day: String? {
        return formatWeekday(time: time)
    }
    
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
    var averages: [Forecast] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        city = try container.decode(City.self, forKey: .city)
        forecasts = try container.decode([Forecast].self, forKey: .forecasts)
        averages = (0...4).map({ getAvg(day: $0) })
    }
    
    private func getAvg(day: Int) -> Forecast {
        return self[day, 0]
//        var avgTemp = 0.0, avgMin = 0.0, avgMax = 0.0
//        var avgWind = 0.0
//        for i in 0...7 {
//            let forecast = self[day, i]
//            avgTemp += forecast.temp.curr
//            avgMin += forecast.temp.min
//            avgMax += forecast.temp.max
//            avgWind += forecast.wind.speed
//        }
//        let temp = Temp(curr: avgTemp / 8.0, min: avgMin / 8.0, max: avgMax / 8.0)
//        let wind = Wind(speed: avgWind / 8.0)
//        let mid = self[day, 0]
//        return Forecast(time: mid.time, temp: temp, info: mid.info, wind: wind, date: mid.date)
    }
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case forecasts = "list"
        case city
    }
    
    subscript(day: Int) -> Forecast {
        return averages[day]
    }
        
    subscript(day: Int, interval: Int) -> Forecast {
        return forecasts[day * 8 + interval]
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
    
    var day: String? {
        return formatWeekday(time: time)
    }
    
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
    
    var current: String {
        return String(format: "%.0f\(unit)", usingMetric ? curr : curr.fahrenheit)
    }
    
    var high: String {
        return String(format: "%.0f\(unit)", usingMetric ? max : max.fahrenheit)
    }
    
    var low: String {
        return String(format: "%.0f\(unit)", usingMetric ? min : min.fahrenheit)
    }
    
    var highLow: String {
        return usingMetric ? String(format: "%.0f/%.0f\(unit)", max, min) :
            String(format: "%.0f/%.0f\(unit)", max.fahrenheit, min.fahrenheit)
    }
    
    var unit: String {
        return usingMetric ? "° C" : "° F"
    }
    
    enum CodingKeys: String, CodingKey {
        case curr = "temp"
        case min = "temp_min"
        case max = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double
    
    var spd: String {
        return String(format: "%.2f \(unit)", usingMetric ? speed : speed.mph)
    }
    
    var unit: String {
        return usingMetric ? "m/s" : "mph"
    }
    
    enum CodingKeys: String, CodingKey {
        case speed
    }
}


fileprivate func formatWeekday(time : Int) -> String? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    let interval = TimeInterval(exactly: time)!
    let date = Date(timeIntervalSince1970: interval)
    let dayIndex = Calendar.current.component(.weekday, from: date) - 1
    let weekday = formatter.weekdaySymbols[dayIndex]
    return weekday.capitalized
}
