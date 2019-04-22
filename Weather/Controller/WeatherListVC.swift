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
    @IBOutlet weak var addCityBtn: UIButton!
    
    let weatherVM = WeatherVM(WeatherService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavbarClear()
        table.tableFooterView = UIView()
        addCityBtn.addTarget(self, action: #selector(showPlaces), for: .touchUpInside)
        loadSavedCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
            if let error = error {
                let msg = (error as? ServiceError)?.localizedDescription ?? error.localizedDescription
                self.showAlert(title: "Error", msg: msg)
                return
            }
            DispatchQueue.main.async {
                if self.weatherVM.numOfCities == 1 {
                    self.table.appendToEnd(sections: [0, 1])
                } else { self.table.appendToEnd(sections: [0]) }
            }
        }
    }
    
    @objc func showPlaces() {
        let placePicker = GMSPlacePicker()
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
    
    var noCities: Bool { return weatherVM.numOfCities == 0 }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addCityBtn.isHidden = !noCities
        if noCities { return 0 }
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
            cell.layer.zPosition = 0
        } else {
            cell.addBtn.addTarget(self, action: #selector(showPlaces), for: .touchUpInside)
            cell.addBtn.bringSubviewToFront(view)
            cell.layer.zPosition = 1
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
            if noCities { tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)}
            table.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
