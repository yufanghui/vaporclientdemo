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
    
    /// 从十六进制字符串创建UIColor
    /// - Parameter hex: 十六进制字符串，可以以"#"开头或不带"#"
    convenience init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        var hexNumber: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&hexNumber)
        
        let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexNumber & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
