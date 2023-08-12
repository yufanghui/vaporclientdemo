//
//  ColorInfo.swift
//  vaporclientdemo
//
//  Created by neo on 2023/8/12.
//

import UIKit

class ColorInfo{
    var color:UIColor?{
        return UIColor(hex: self.colorString)
    }
    var selected:Bool = false
    var colorString:String
    
    init(selected: Bool, colorString: String) {
        self.selected = selected
        self.colorString = colorString
    }
}
