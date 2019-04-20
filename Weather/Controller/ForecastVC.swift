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
    var forecastCard: ForecastCardVC!
    var handleHgt: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        currWeather.set(forecastVM.current)
        setupCard()
        loadForecasts()
        
//        setupGestures()
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
                self.forecastCard.forecastVM = self.forecastVM
            }
        }
    }
    
    func setupCard() {
        forecastCard = ForecastCardVC(nibName: "ForecastCardVC", bundle: nil)
        addChild(forecastCard)
        view.addSubview(forecastCard.view)
        handleHgt = forecastCard.handle.frame.height
        forecastCard.view.frame = CGRect(x: 0, y: view.frame.height - handleHgt, width: view.frame.width, height: 600)
        forecastCard.view.clipsToBounds = true
    }
    
    func setupGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        forecastCard.handle.addGestureRecognizer(pan)
        forecastCard.handle.addGestureRecognizer(tap)
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        
    }
}
