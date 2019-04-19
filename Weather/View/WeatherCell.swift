//
//  WeatherCell.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var hiTemp: UILabel!
    @IBOutlet weak var loTemp: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.setGradientBackground()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(weatherData: CurrentWeather) {
        cityLabel.text = weatherData.city
        let temp = weatherData.temp
        hiTemp.text = "\(temp.max)"
        loTemp.text = "\(temp.min)"
    }

}
