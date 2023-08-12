//
//  UserConfiguration.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit

enum FontType: String {
    case simplified = "Simplified"
    case traditional = "Traditional"
}


class UserConfiguration {
    
    private enum Keys {
        static let favoriteColor = "favoriteColorComponents"
        static let favoriteFont = "favoriteFontName"
    }

    static let shared = UserConfiguration()
    
    var fontChoice: FontType = .simplified
    

    private init() {}

    var favoriteColor: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.favoriteColor)
        }
        set {
            if let colorString = newValue {
                UserDefaults.standard.set(colorString, forKey: Keys.favoriteColor)
            }
        }
    }

    var favoriteFont: String? {
        get {
            guard let fontName = UserDefaults.standard.string(forKey: Keys.favoriteFont) else { return nil }
            return fontName
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.favoriteFont)
        }
    }
}

