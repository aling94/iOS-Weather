//
//  ViewControllers.swift
//  Weather
//
//  Created by Alvin Ling on 4/19/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var navbarHeight: CGFloat {
        return navigationController?.navigationBar.frame.size.height ?? 0
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func makeNavbarClear() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.isTranslucent = true
        navigationBar?.tintColor = .white
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
