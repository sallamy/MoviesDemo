//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by mohamed salah on 18/01/2024.
//

import Foundation
import Combine

public class MovieDetailsViewModel{
    
    private let useCase: MovieDetailsUseCaseInterface!
    let movieDetailsObserver = PassthroughSubject<Movie, Never>()
    var isLoading = PassthroughSubject<Bool, Never>()
    var errorObserver = PassthroughSubject<Error, Never>()
    
    public init(useCase: MovieDetailsUseCaseInterface!) {
        self.useCase = useCase
    }
    
    public  func fetchMovieDetails(movieId: Int) async {
        do {
            self.isLoading.send(true)
            if let result = try await self.useCase.executeFetchDetails(movieId: movieId) {
                self.movieDetailsObserver.send(result)
            }
            
            self.isLoading.send(false)
        } catch let error  {
            self.isLoading.send(false)
            errorObserver.send(error)
        } 
    }
}
