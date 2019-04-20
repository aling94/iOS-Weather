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
                completion(nil)
            } else { completion(error) }
            
        }
    }

    func avgWeather(day: Int) -> Forecast {
        return data[day]
    }
    
    func weather(day: Int, interval: Int) -> Forecast {
        return data[day, interval]
    }
}
