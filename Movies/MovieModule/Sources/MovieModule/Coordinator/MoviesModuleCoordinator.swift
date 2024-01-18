//
//  File.swift
//
//
//  Created by mohamed salah on 18/01/2024.
//

import Foundation
import DependenciesModule
import Swinject
import UIKit

public protocol MoviesModuleCoordinatorProvider {
    func start()
    func navigateToDetailsViewController(movieId: Int)
}

public class MoviesModuleCoordinator: MoviesModuleCoordinatorProvider  {
    
    private weak var navigationController: UINavigationController?
    let provider: MoviesListViewControllerProviderProtocol!
    
    public init(_ provider: MoviesListViewControllerProviderProtocol,
                navigationController: UINavigationController) {
        self.provider = provider
        self.navigationController = navigationController
        
    }
    
    public func start() {
        let viewController = self.provider.getListViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func navigateToDetailsViewController(movieId: Int) {
        let viewController = self.provider.getDetailsViewController(movieId: movieId)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
