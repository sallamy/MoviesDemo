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
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.isHidden = false
        setRootViewController()
        return true
    }
    
    func setRootViewController() {
        self.window?.rootViewController = UINavigationController(rootViewController: ContainerManager.shared.createMoviesListViewController())
    }

}

