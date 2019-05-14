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
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var handleTop: NSLayoutConstraint!
    @IBOutlet weak var handleLead: NSLayoutConstraint!
    @IBOutlet weak var handleTrail: NSLayoutConstraint!
    
    var height: CGFloat {
        return (handle?.frame.height ?? 0) + (content?.frame.height ?? 0)
    }
    
    var forecastVM: ForecastVM! {
        didSet{
            setupWeatherInfo()
            collection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "WeatherCollectionCell", bundle: nil)
        collection.register(nibName, forCellWithReuseIdentifier: "Cell")
//        handle.setGradientBackground(.darkOrange, .liteOrange)
        handle.backgroundColor = .darkOrange
    }
    
    func setupWeatherInfo() {
        guard let vm = forecastVM else { return }
        todayInfo.set(vm.avgWeather(day: 0))
        tmrwInfo.set(vm.avgWeather(day: 1))
    }
    
    func shiftHandleUp(by amount: CGFloat) {
        handleTop.constant = -amount
    }
    
    func shrinkHandle(by amount: CGFloat) {
        handleLead.constant = amount
        handleTrail.constant = -amount
    }
    
    func resetHandle() {
        handleTop.constant = 0
        handleLead.constant = 0
        handleTrail.constant = 0
    }
}

extension ForecastCardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastVM?.numOfForecasts ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? WeatherCollectionCell else {
            return UICollectionViewCell()
        }
        let forecast = forecastVM.avgWeather(day: indexPath.item)
        cell.set(forecast)
        if [0, 1].contains(indexPath.row) { cell.setAlternateDay(indexPath.row) }
        return cell
    }
}

extension ForecastCardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 155, height: 190)
    }
}
