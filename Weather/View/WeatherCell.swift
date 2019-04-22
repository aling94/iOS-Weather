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
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var infoView: WeatherInfoView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        infoView?.setGradientBackground(.darkOrange, .liteOrange)
        if addBtn != nil {
            btnView.setGradientBackground(.darkOrange, .liteOrange)
            btnView.cornerRadius = btnView.frame.height / 2
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(_ data: CurrentWeather) {
        infoView.set(data)
    }
}
