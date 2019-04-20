//
//  WeatherListVC.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit
import GooglePlaces

class WeatherListVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let weatherVM = WeatherVM(WeatherService.shared)
    let placePicker = GMSPlacePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        setupPlacePicker()
        loadSavedCities()
    }
    
    func setupPlacePicker() {
        placePicker.selectPlaceAction = { [unowned self] in self.addCity($0) }
    }
    
    func loadSavedCities() {
        weatherVM.loadCities { (error) in
            if let error = error?.localizedDescription {
                self.showAlert(title: "Error", msg: error)
                return
            }
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    func addCity(_ place: GMSPlace) {
        self.weatherVM.getCity(place) { (error) in
            if let error = error?.localizedDescription {
                self.showAlert(title: "Error", msg: error)
                return
            }
            DispatchQueue.main.async {
                self.table.appendToEnd(section: 0)
            }
        }
    }
    
    @IBAction func addCityClicked(sender: Any) {
        present(placePicker, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ForecastVC,
            let selected = table.indexPathForSelectedRow else { return }
        let current = weatherVM.weather(at: selected)
        vc.forecastVM = ForecastVM(WeatherService.shared, current: current)
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
        cell.set(data)
        return cell
    }
}
