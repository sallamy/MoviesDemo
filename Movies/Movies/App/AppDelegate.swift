//
//  AppDelegate.swift
//  Movies
//
//  Created by mohamed salah on 16/01/2024.
//

import UIKit
import MovieModule



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appManager: AppManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.isHidden = false
        appManager = AppManager(window: self.window)
        
        return true
    }
 

}

