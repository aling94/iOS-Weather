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
    let placePicker = GMSPlacePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        setupPlacePicker()
        loadSavedCities()
    }
    
    func setupPlacePicker() {
        placePicker.selectPlaceAction = { [unowned self] place in
            let loc = place.coordinate
            print(loc)
            self.addCity(loc.latitude, loc.longitude)
        }
    }
    
    func loadSavedCities() {
        
    }
    
    func addCity(_ lat: Double, _ lon: Double) {
        self.weatherVM.fetchData(lat, lon) { (error) in
            if let error = error?.localizedDescription {
                self.showAlert(title: "Error", msg: error)
                return
            }
            DispatchQueue.main.async {
                self.table.appendToEnd(section: 0)
            }
        }
    }
    
    @IBAction func addCityClicked(sender: UIButton) {
        present(placePicker, animated: true)
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
