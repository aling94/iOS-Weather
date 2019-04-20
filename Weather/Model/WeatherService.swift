//
//  WeatherService.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static let coordReq = "%@?lat=%f&lon=%f&units=metric&APPID=%@"
    static let cityIDReq = "%@?id=%d&units=metric&APPID=%@"
    static let batchReq = "group?id=%@&units=metric&APPID=%@"
    
    static func url(_ lat: Double, _ lon: Double, type: ForecastType) -> URL? {
        let params = String(format: coordReq, type.rawValue, lat, lon, APIKeys.weather)
        return URL(string: baseURL + params)
    }
    
    static func url(_ cityID: Int, type: ForecastType) -> URL? {
        let params = String(format: cityIDReq, type.rawValue, cityID, APIKeys.weather)
        return URL(string: baseURL + params)
    }
    
    static func url(_ cityIDs: [Int]) -> URL? {
        let ids = cityIDs.map( {"\($0)"} ).joined(separator: ",")
        let params = String(format: batchReq, ids, APIKeys.weather)
        return URL(string: baseURL + params)
    }
    
    // Helper to send request to API
    private func callAPI<T: Codable>(_ url: URL, completion: @escaping (T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                if let response = response { print(response) }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data!)
                completion(results, nil)
            } catch { completion(nil, error) }
        }.resume()
    }
    
    // Fetch current or daily weather for a specific coordinate
    func fetchData<T: Codable>(lat: Double, lon: Double, type: ForecastType, completion: @escaping (T?, Error?) -> Void) {
        if let request = WeatherService.url(lat, lon, type: type) {
            callAPI(request, completion: completion)
        } else { completion(nil, ServiceError.invalidURL) }
    }
    
    // Fetch current or daily weather for a specific coordinate
    func fetchData<T: Codable>(cityID: Int, type: ForecastType, completion: @escaping (T?, Error?) -> Void) {
        if let request = WeatherService.url(cityID, type: type) {
            callAPI(request, completion: completion)
        } else { completion(nil, ServiceError.invalidURL) }
    }
    
    // Fetch multiple the current weather for multiple cities
    func fetchData(cityIDs: [Int], completion: @escaping (WeatherList?, Error?) -> Void) {
        if let request = WeatherService.url(cityIDs) {
            callAPI(request, completion: completion)
        } else { completion(nil, ServiceError.invalidURL) }
    }
}

enum ForecastType: String {
    case current = "weather"
    case daily = "forecast"
}

enum ServiceError: String, Error {
    case invalidURL = "URL is invalid"
    case parseFailed = "Failed to parse data"
    case alreadyAdded = "You have already added this location"
}
