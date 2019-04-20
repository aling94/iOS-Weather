//
//  ForecastVC.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController {
    
    @IBOutlet weak var currWeather: WeatherInfoView!
    @IBOutlet weak var todayWeather: WeatherInfoView!
    @IBOutlet weak var tmrwWeather: WeatherInfoView!
    
    var forecastVM: ForecastVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        currWeather.set(forecastVM.current)
        loadForecasts()
    }
    
    func loadForecasts() {
        forecastVM.fetchForecasts { (error) in
            if let error = error?.localizedDescription {
                self.showAlert(title: "Error", msg: error)
                return
            }
            
            DispatchQueue.main.async {
                self.todayWeather.set(self.forecastVM.weather(at: 0))
                self.tmrwWeather.set(self.forecastVM.weather(at: 1))
            }
        }
    }
}
