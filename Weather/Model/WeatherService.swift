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
    
    static let baseURL = "api.openweathermap.org/data/2.5/%@?lat=%f&lon=%f&APPID=%@"
    
    static func url(_ lat: Double, _ lon: Double, type: ForecastType) -> URL? {
        let url = String(format: baseURL, type.rawValue, lat, lon, APIKeys.weather)
        return URL(string: url)
    }
    
    func fetchData<T: Codable>(lat: Double, lon: Double, type: ForecastType, completion: @escaping (T?, Error?) -> Void) {
        guard let request = WeatherService.url(lat, lon, type: type) else {
            completion(nil, ServiceError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                if let response = response { print(response) }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data!)
                completion(results, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
    }
}

enum ForecastType: String {
    case current = "weather"
    case daily = "forecast"
}

enum ServiceError: String, Error {
    case invalidURL = "URL is invalid"
    case parseFailed = "Failed to parse data"
}
