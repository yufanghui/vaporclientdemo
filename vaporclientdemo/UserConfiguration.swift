//
//  UserConfiguration.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit

class UserConfiguration {
    
    private enum Keys {
        static let favoriteColor = "favoriteColorComponents"
        static let favoriteFont = "favoriteFontName"
    }

    static let shared = UserConfiguration()

    private init() {}

    var favoriteColor: UIColor? {
        get {
            if let components = UserDefaults.standard.array(forKey: Keys.favoriteColor) as? [CGFloat], components.count == 4 {
                return UIColor(components: (red: components[0], green: components[1], blue: components[2], alpha: components[3]))
            }
            return nil
        }
        set {
            if let components = newValue?.components {
                UserDefaults.standard.set([components.red, components.green, components.blue, components.alpha], forKey: Keys.favoriteColor)
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

