//
//  WeatherVM.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

class WeatherVM {
    
    private let service: WeatherService
    private var data: [CurrentWeather] = []
    
    var numOfCities: Int {
        return data.count
    }
    
    init(_ service: WeatherService) {
        self.service = service
    }
    
    func fetchData(_ lat: Double, _ lon: Double, completion: @escaping (Error?) -> Void) {
        service.fetchData(lat: lat, lon: lon, type: .current) { (results: CurrentWeather?, error) in
            if let results = results {
                self.data.append(results)
                completion(nil)
            } else { completion(error) }
        }
    }
    
    func fetchData(cityIDs: [Int], completion: @escaping (Error?) -> Void) {
        
    }
    
    func weather(at indexPath: IndexPath) -> CurrentWeather {
        return weather(at: indexPath.row)
    }
    
    func weather(at index: Int) -> CurrentWeather {
        return data[index]
    }
    
    
}
