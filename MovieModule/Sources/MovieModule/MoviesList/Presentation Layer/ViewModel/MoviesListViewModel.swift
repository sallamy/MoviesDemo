//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by mohamed salah on 16/01/2024.
//

import Foundation
import Combine

public class MoviesListViewModel {
    let useCase: MoviesListUseCase!
    let moviesListObserver = PassthroughSubject<[Movie], Never>()
    var isLoading = PassthroughSubject<Bool, Never>()

    public init(useCase: MoviesListUseCase!) {
        self.useCase = useCase
    }
    
    func fetchMovies() async {
        
        do {
            self.isLoading.send(true)
            let result = try await self.useCase.executeFetchData()
            self.moviesListObserver.send(result?.results ?? [])
            self.isLoading.send(false)
        } catch let error  {
            self.isLoading.send(false)
        } catch {}
    
       
    }
}
