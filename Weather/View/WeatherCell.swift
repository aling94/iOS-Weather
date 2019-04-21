//
//  WeatherCell.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var hiTemp: UILabel!
    @IBOutlet weak var loTemp: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        container.setGradientBackground(.darkOrange, .liteOrange)
        if addBtn != nil {
            container.cornerRadius = container.frame.height / 2
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ data: CurrentWeather) {
        cityLabel.text = data.city
        hiTemp.text = data.temp.high
        loTemp.text = data.temp.low
        if let iconName = data.info.first?.icon, let image = UIImage(named: iconName) {
            icon.image = image
        }
    }
}
