//
//  Views.swift
//  Weather
//
//  Created by Alvin Ling on 4/19/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

extension UIView {
    
    func setGradientBackground() {
        backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.random.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 0.5)
    }
}
