//
//  WeatherListVC.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class WeatherListVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let weatherVM = WeatherVM(WeatherService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension WeatherListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherVM.numOfCities
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? WeatherCell else {
            return UITableViewCell()
        }
        let data = weatherVM.weather(at: indexPath)
        cell.set(weatherData: data)
        return cell
    }
}
