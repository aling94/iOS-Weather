//
//  ForecastCardVC.swift
//  Weather
//
//  Created by Alvin Ling on 4/20/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class ForecastCardVC: UIViewController {

    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var todayInfo: WeatherInfoView!
    @IBOutlet weak var tmrwInfo: WeatherInfoView!
    
    var forecastVM: ForecastVM! {
        didSet{
            setupWeatherInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupWeatherInfo() {
        guard let vm = forecastVM else { return }
        todayInfo.set(vm.weather(at: 0))
        tmrwInfo.set(vm.weather(at: 1))
    }
    
    
    
}
