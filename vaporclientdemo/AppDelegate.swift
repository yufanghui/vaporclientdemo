//
//  AppDelegate.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFont()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
    
    func setupFont() {
        let fontNames = [
            "FZJFSB.TTF",
            "FZFSJW.TTF",
            "FZKTK.TTF",
            "FZZJ-GFXLXSJF.TTF",
            "FZZJ-GFXLXSJW.TTF",
            "ZKTZhuTKJF.TTF",
            "FZFSK.TTF",
            "FZFSB.TTF",
            "FZFSFW.TTF",
            "FZKTB.TTF",
            "FZKTFW.TTF",
            "FZJKTB.TTF",
            "FZKTJW.TTF",
            "FZHTB.TTF",
            "FZHTFW.TTF",
            "FZSSK.TTF",
            "FZSSFW.TTF",
            "FZJSSB.TTF",
            "FZSSJW.TTF",
            "FZZhaoMFXSJF.TTF",
            "FZZJ-HYWKJF.TTF",
            "FZWuYRXSJF.TTF",
            "FZZJ-SYTJW.TTF"
        ]

        for font in fontNames{
            let bundle = Bundle.main
            registerFont(withFilenameString: font, bundle: bundle)
        }
    }
    
    func registerFont(withFilenameString filenameString: String, bundle: Bundle) {
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("Failed to register font - path for resource not found.")
            return
        }
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("Failed to register font - font data could not be loaded.")
            return
        }
        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("Failed to register font - data provider could not be loaded.")
            return
        }
        guard let fontRef = CGFont(dataProvider) else {
            print("Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
            print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

}

