//
//  WeatherCell.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit


let orangeDark = 0xf8a346
let orangeLite =  0xffe676
let silverDark = 0xaab3cc
let silverLite = 0xdde9fa
let grayDark =  0xaaaaaa
let grayLite = 0xededed

class WeatherCell: UITableViewCell {
    
    

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var hiTemp: UILabel!
    @IBOutlet weak var loTemp: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        container.setGradientBackground(orangeDark, orangeLite)
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
