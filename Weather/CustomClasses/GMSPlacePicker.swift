//
//  GMSPlacePicker.swift
//  Weather
//
//  Created by Alvin Ling on 4/19/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import GooglePlaces

class GMSPlacePicker: GMSAutocompleteViewController {
    
    var selectPlaceAction: ((GMSPlace) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let fields: [GMSPlaceField] = [.name, .coordinate, .placeID]
        let settingVal = fields.reduce(0, { $0 | UInt($1.rawValue) } )
        
        placeFields = GMSPlaceField(rawValue: settingVal)!
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteFilter = filter
    }
}

extension GMSPlacePicker: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectPlaceAction?(place)
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
