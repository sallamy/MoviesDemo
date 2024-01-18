//
//  MainContainer.swift
//  Movies
//
//  Created by mohamed salah on 17/01/2024.
//

import Foundation
import Swinject
import NetworkLayer


public class ContainerManager {
    let container = Container()
    let baseUrl = "https://api.themoviedb.org"
    public static let shared = ContainerManager()
    init() {
        registerMovieList()
        registerMovieDetails()
    }
    
    public func createMoviesListViewController() -> MoviesListViewController {
        self.container.resolve(MoviesListViewController.self)!
    }
    
    public func createMoviesDetailsViewController(movieId: Int) -> MovieDetailsViewController {
        self.container.resolve(MovieDetailsViewController.self, argument: movieId)!
    }
    
   private func registerMovieList() {
        container.register(NetworkService.self) { _ in
            NetworkManager(baseURL: self.baseUrl)
        }
        
        container.register(MoviesListRepositoryProtocol.self) { r in
            MoviesListRepository(clientService: r.resolve(NetworkService.self)!)
        }
        
        container.register(MoviesListUseCaseInterface.self) { r in
            MoviesListUseCase(repo: r.resolve(MoviesListRepositoryProtocol.self)!)
        }
        
        container.register(MoviesListViewModel.self) { r in
            MoviesListViewModel(useCase: r.resolve(MoviesListUseCaseInterface.self)!)
        }
        
        container.register(MoviesListViewController.self) { r in
            MoviesListViewController(with: r.resolve(MoviesListViewModel.self)!)
        }
    }
    
    private func registerMovieDetails() {
      
        container.register(MovieDetailsRepositoryProtocol.self) { r in
            MovieDetailsRepository(clientService: r.resolve(NetworkService.self)!)
        }
        
        container.register(MovieDetailsUseCaseInterface.self) { r in
            MovieDetailsUseCase(repo: r.resolve(MovieDetailsRepositoryProtocol.self)!)
        }
        
        container.register(MovieDetailsViewModel.self) { r in
            MovieDetailsViewModel(useCase: r.resolve(MovieDetailsUseCaseInterface.self)!)
        }

        container.register(MovieDetailsViewController.self) { resolver, id in
            MovieDetailsViewController(with: resolver.resolve(MovieDetailsViewModel.self)!, movieId: id)
        }
    }
}
