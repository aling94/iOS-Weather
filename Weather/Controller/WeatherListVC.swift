//
//  WeatherListVC.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class WeatherListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherService.shared.fetchData(lat: 0, lon: 0, type: .current) { (weather: CurrentWeather?, error) in
            if let errorMsg = error?.localizedDescription {
                self.showAlert(title: "Error!", msg: errorMsg )
                return
            }
            guard let weather = weather else { return }
            print(weather)
            
        }

    }


}
