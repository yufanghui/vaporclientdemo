//
//  FontInfo.swift
//  vaporclientdemo
//
//  Created by neo on 2023/8/11.
//

import Foundation

class FontInfo {
    var fontName:String?
    var displayName:String?
    var selected:Bool = false
    init(fontName: String? = nil, displayName: String? = nil, selected: Bool) {
        self.fontName = fontName
        self.displayName = displayName
        self.selected = selected
    }
}
