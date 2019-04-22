//
//  Views.swift
//  Weather
//
//  Created by Alvin Ling on 4/19/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

extension UIView {

    func setGradientBackground(_ startColor: Int, _ endColor: Int) {
        setGradientBackground(UIColor(rgb: startColor), UIColor(rgb: endColor))
    }
    
    func setGradientBackground(_ startColor: UIColor, _ endColor: UIColor = .white) {
        backgroundColor = .white
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        
        set { layer.borderColor = newValue.cgColor }
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static var darkOrange: UIColor { return UIColor(rgb: 0xf8a346) }
    static var liteOrange: UIColor { return UIColor(rgb: 0xffe676) }
    static var darkSilver: UIColor { return UIColor(rgb: 0xaab3cc) }
    static var liteSilver: UIColor { return UIColor(rgb: 0xdde9fa) }
    static var darkGray: UIColor { return UIColor(rgb: 0xaaaaaa) }
    static var liteGray: UIColor { return UIColor(rgb: 0xededed) }
    static var darkBlue: UIColor { return UIColor(rgb: 0x4ea0d0) }
    static var liteBlue: UIColor { return UIColor(rgb: 0x114b70) }
}

extension UIButton {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.masksToBounds = false
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
    }
}

extension UITableView {
    
    func appendToEnd(sections: [Int]) {
        let idps = sections.map { IndexPath(row: self.numberOfRows(inSection: $0), section: $0) }
        beginUpdates()
        insertRows(at: idps, with: .right)
        endUpdates()
    }
}
