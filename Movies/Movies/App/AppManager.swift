//
//  AppManager.swift
//  Movies
//
//  Created by mohamed salah on 18/01/2024.
//

import Foundation
import MovieModule
import DependenciesModule
import UIKit
import Swinject

class AppManager {
    
    let navigationController = UINavigationController()
    var window: UIWindow?
    let container = Container()
    
    init(window: UIWindow? = nil) {
        self.window = window
        setupDI()
        setRootViewController()
    }
    
    func setupDI() {
        MovieDIContainer.setup(self.container, navigationController: self.navigationController)
    }
    
    func setRootViewController() {
        let provider = self.container.resolve(MoviesListViewControllerProviderProtocol.self)!
        self.navigationController.setViewControllers([provider.getListViewController()], animated: false)
        self.window?.rootViewController = self.navigationController
    }
    
}
