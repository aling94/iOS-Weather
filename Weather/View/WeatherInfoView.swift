//
//  WeatherInfoView.swift
//  Weather
//
//  Created by Alvin Ling on 4/19/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {

    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var hiLow: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func set(weatherData: CurrentWeather) {
        temp?.text = "\(weatherData.temp.curr)"
        cityName?.text = weatherData.city
        wind?.text = "\(weatherData.wind.speed) m/s"
        guard let info = weatherData.info.first else { return }
        state?.text = info.state
    }
    
    func set(weatherData: DailyWeather) {
        
    }
}
