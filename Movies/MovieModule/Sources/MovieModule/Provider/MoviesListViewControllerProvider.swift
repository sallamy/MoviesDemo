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

class MoviesListViewControllerProvider: MoviesListViewControllerProviderProtocol {
    
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func getListViewController() -> UIViewController {
        let viewModel = self.resolver.resolve(MoviesListViewModel.self)!
        return MoviesListViewController(with: viewModel)
    }
    
    func getDetailsViewController(movieId: Int) -> UIViewController {
        let viewModel = self.resolver.resolve(MovieDetailsViewModel.self)!
        return MovieDetailsViewController(with: viewModel, movieId: movieId)
    }
}
