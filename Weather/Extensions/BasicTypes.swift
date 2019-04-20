//
//  BasicTypes.swift
//  Weather
//
//  Created by Alvin Ling on 4/19/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import Foundation

extension Double {
    
    // MARK: - Unit conversions
    var fahrenheit: Double {
        return (self * 9.0 / 5.0) + 32
    }
    
    var celcius: Double {
        return (self - 32) * 5.0 / 9.0
    }
    
    var mph: Double {
        return self * 2.237
    }
    
    var ms: Double {
        return self / 2.237
    }
}
