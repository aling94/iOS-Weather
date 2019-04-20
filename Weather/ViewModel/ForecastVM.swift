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
    let cityID: Int
    var data: DailyWeather?
    
    init(_ service: WeatherService, cityID: Int) {
        self.service = service
        self.cityID = cityID
    }
    
    func fetchForecasts(completion: @escaping (Error?) -> Void) {
        service.fetchData(cityID: cityID, type: .daily) { (results: DailyWeather?, error) in
            if let results = results {
                self.data = results
            } else { completion(error) }
            
        }
    }
}
