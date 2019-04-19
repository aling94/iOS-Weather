//
//  WeatherService.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

class WeatherService {
    private init() {}
    
    static let shared = WeatherService()
    
    func fetchData<T: Codable>(_ url: String, completion: @escaping (T?, Error?) -> Void) {
        guard let request = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
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
