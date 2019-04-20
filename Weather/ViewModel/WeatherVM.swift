//
//  WeatherVM.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import GooglePlaces

class WeatherVM {
    
    private let service: WeatherService
    private var data: [CurrentWeather] = []
    private var cityIDs: [Int] = []
    private var placeIDs: [String] = []
    
    var numOfCities: Int {
        return data.count
    }
    
    init(_ service: WeatherService) {
        self.service = service
        if let cities = UserDefaults.standard.value(forKey: "cities") as? [Int] {
            cityIDs = cities
        }
        if let places = UserDefaults.standard.value(forKey: "places") as? [String] {
            placeIDs = places
        }
    }
    
    // Get a city by coordinate and add it to the list
    func getCity(_ place: GMSPlace, completion: @escaping (Error?) -> Void) {
        guard let id = place.placeID, !placeIDs.contains(id) else {
            completion(ServiceError.alreadyAdded)
            return
        }
        let loc = place.coordinate
        service.fetchData(lat: loc.latitude, lon: loc.longitude, type: .current) { (results: CurrentWeather?, error) in
            if let results = results {
                self.data.append(results)
                self.cityIDs.append(results.cityID)
                self.placeIDs.append(id)
                UserDefaults.standard.set(self.cityIDs, forKey: "cities")
                UserDefaults.standard.set(self.placeIDs, forKey: "places")
                completion(nil)
            } else { completion(error) }
        }
    }
    
    // Load the saved list of cities
    func loadCities(completion: @escaping (Error?) -> Void) {
        guard !cityIDs.isEmpty else { return }
        service.fetchData(cityIDs: cityIDs) { (results, error) in
            if let results = results {
                self.data = results.cities
                completion(nil)
            } else { completion(error) }
        }
    }
    
    func weather(at indexPath: IndexPath) -> CurrentWeather {
        return weather(at: indexPath.row)
    }
    
    func weather(at index: Int) -> CurrentWeather {
        return data[index]
    }
}
