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
    var placePicker: GMSPlacePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        table.tableFooterView = UIView()
        setupPlacePicker()
        loadSavedCities()
    }
    
    func setupPlacePicker() {
        
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
    
    @objc func showPlaces() {
        placePicker = GMSPlacePicker()
        placePicker.selectPlaceAction = { [unowned self] in self.addCity($0) }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? weatherVM.numOfCities : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = indexPath.section == 0 ? "Cell" : "ButtonCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id) as? WeatherCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            let data = weatherVM.weather(at: indexPath)
            cell.set(data)
        } else {
            cell.addBtn.addTarget(self, action: #selector(showPlaces), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 1   
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weatherVM.deleteCity(at: indexPath.row)
            table.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            table.endUpdates()
        }
    }
}
