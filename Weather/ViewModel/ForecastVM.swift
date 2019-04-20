//
//  ForecastVM.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

class ForecastVM {
    
    let service: WeatherService
    let current: CurrentWeather
    var data: DailyWeather!
    
    init(_ service: WeatherService, current: CurrentWeather) {
        self.service = service
        self.current = current
    }
    
    func fetchForecasts(completion: @escaping (Error?) -> Void) {
        service.fetchData(cityID: current.cityID, type: .daily) { (results: DailyWeather?, error) in
            if let results = results {
                self.data = results
            } else { completion(error) }
            
        }
    }
    
    func weather(at index: Int) -> Forecast {
        return data[index]
    }
}
