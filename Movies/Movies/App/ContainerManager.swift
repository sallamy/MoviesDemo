//
//  MainContainer.swift
//  Movies
//
//  Created by mohamed salah on 17/01/2024.
//

import Foundation
import Swinject
import MovieModule
import NetworkLayer

class ContainerManager {
    let container = Container()
    static let shared = ContainerManager()
    init() {
        registerMovieList()
    }
    
    func createMoviesListViewController() -> MoviesListViewController {
        self.container.resolve(MoviesListViewController.self)!
    }
    
    func registerMovieList() {
        container.register(NetworkService.self) { _ in
            NetworkManager(baseURL: baseUrl)
        }
        
        container.register(MoviesListRepositoryProtocol.self) { r in
            MoviesListRepository(clientService: r.resolve(NetworkService.self)!)
        }
        
        container.register(MoviesListUseCaseInterface.self) { r in
            MoviesListUseCase(repo: r.resolve(MoviesListRepositoryProtocol.self)!)
        }
        
        container.register(MoviesListViewModel.self) { r in
            MoviesListViewModel(useCase: r.resolve(MoviesListUseCaseInterface.self) as? MoviesListUseCase)
        }
        
        container.register(MoviesListViewController.self) { r in
            MoviesListViewController(with: r.resolve(MoviesListViewModel.self)!)
        }
    }
}
