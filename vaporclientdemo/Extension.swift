//
//  Extension.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/10.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static var randomBgColor: UIColor {
        let red = CGFloat(0.3 + drand48() * 0.7)
        let green = CGFloat(0.3 + drand48() * 0.7)
        let blue = CGFloat(0.3 + drand48() * 0.7)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        return getRed(&red, green: &green, blue: &blue, alpha: &alpha) ? (red, green, blue, alpha) : nil
    }
    
    convenience init?(components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)) {
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: components.alpha)
    }
}
