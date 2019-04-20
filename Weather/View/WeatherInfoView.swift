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
    
    func set(_ data: CurrentWeather) {
        temp?.text = data.temp.current
        hiLow?.text = data.temp.highLow
        cityName?.text = data.city
        wind?.text = data.wind.spd
        guard let info = data.info.first else { return }
        state?.text = info.state
    }
    
    func set(_ data: Forecast) {
        hiLow?.text = data.temp.highLow
        if let iconName = data.info.first?.icon, let image = UIImage(named: iconName) {
            icon.image = image
        }
    }
}
