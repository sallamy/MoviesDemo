//
//  MainContainer.swift
//  Movies
//
//  Created by mohamed salah on 17/01/2024.
//

import Foundation
import Swinject
import NetworkLayer
import DependenciesModule


public struct MovieDIContainer {

    public static func setup(_ container : Container) {
        container.register(NetworkService.self) { _ in
            NetworkManager()
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
        
        container.register(MovieDetailsRepositoryProtocol.self) { r in
            MovieDetailsRepository(clientService: r.resolve(NetworkService.self)!)
        }
        
        container.register(MovieDetailsUseCaseInterface.self) { r in
            MovieDetailsUseCase(repo: r.resolve(MovieDetailsRepositoryProtocol.self)!)
        }
        
        container.register(MovieDetailsViewModel.self) { r in
            MovieDetailsViewModel(useCase: r.resolve(MovieDetailsUseCaseInterface.self)!)
        }

        container.register(MoviesListViewControllerProviderProtocol.self) { resolver in
            MoviesListViewControllerProvider(resolver: resolver)
        }
        
    }
}
