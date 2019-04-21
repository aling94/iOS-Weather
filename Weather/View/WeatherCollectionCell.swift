//
//  WeatherCollectionCell.swift
//  Weather
//
//  Created by Alvin Ling on 4/20/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class WeatherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var info: WeatherInfoView!
    override func awakeFromNib() {
        super.awakeFromNib()
        info.setGradientBackground(.darkBlue, .liteBlue)
    }

}
