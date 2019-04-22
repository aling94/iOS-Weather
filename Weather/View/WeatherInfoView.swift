//
//  WeatherInfoView.swift
//  Weather
//
//  Created by Alvin Ling on 4/19/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {

    @IBOutlet weak var currTemp: UILabel!
    @IBOutlet weak var hiLow: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var day: UILabel!
    
    func set(_ data: CurrentWeather) {
        cityName?.text = data.city
        wind?.text = data.wind.spd
        setFromInfo(data.info)
        setTemp(data.temp)
    }
    
    func set(_ data: Forecast) {
        day?.text = data.day
        setFromInfo(data.info)
        setTemp(data.temp)
        
    }
    
    private func setTemp(_ temp: Temp) {
        currTemp?.text = temp.current
        hiLow?.text = temp.highLow
        high?.text = temp.high
        low?.text = temp.low
    }
    
    private func setFromInfo(_ info: [Info]) {
        if let stateTxt = info.first?.state { state?.text = stateTxt }
        if let iconName = info.first?.icon, let image = UIImage(named: iconName) {
            icon?.image = image
        }
    }
}
