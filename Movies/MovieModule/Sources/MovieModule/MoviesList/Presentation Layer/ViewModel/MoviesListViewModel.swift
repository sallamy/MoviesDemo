//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by mohamed salah on 16/01/2024.
//

import Foundation
import Combine
import NetworkLayer

public class MoviesListViewModel {
    private let useCase: MoviesListUseCaseInterface!
    public  let moviesListObserver = CurrentValueSubject<[Movie], Never>([])
    var isLoading = PassthroughSubject<Bool, Never>()
    public var selectedIndex = PassthroughSubject<Int, Never>()
    public var errorObserver = PassthroughSubject<APIError, Never>()
    private let moviesModuleCoordinatorProvider: MoviesModuleCoordinatorProvider
    private var cancellables = Set<AnyCancellable>()

    public init(useCase: MoviesListUseCaseInterface!, moviesModuleCoordinatorProvider: MoviesModuleCoordinatorProvider) {
        self.useCase = useCase
        self.moviesModuleCoordinatorProvider = moviesModuleCoordinatorProvider
        observeSelectMovie()
    }
    
    public  func fetchMovies() async {
        do {
            self.isLoading.send(true)
            let result = try await self.useCase.executeFetchData()
            self.moviesListObserver.send(result?.results ?? [])
            self.isLoading.send(false)
        } catch let error  {
            self.isLoading.send(false)
            errorObserver.send(error as! APIError)
        }
    }
    
    public func observeSelectMovie() {
        self.selectedIndex.sink { index in
            if let movieId = self.moviesListObserver.value[index].id {
                self.moviesModuleCoordinatorProvider.navigateToDetailsViewController(movieId: movieId)
            }
        }.store(in: &cancellables)
    }
}
