//
//  SubmitEmailUseCase.swift
//  BanqueMisr-UAE
//
//  Created by mohamed salah on 11/04/2023.
//

import Foundation
import Combine
import NetworkLayer

// sourcery: AutoMockable
public protocol MoviesListUseCaseInterface {
    func executeFetchData() async throws -> MoviesListModel?
}

public class MoviesListUseCase: MoviesListUseCaseInterface  {
    
    private let repo: MoviesListRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(repo: MoviesListRepositoryProtocol) {
        self.repo = repo
    }
    
    public func executeFetchData() async throws -> MoviesListModel? {
        return try await withCheckedThrowingContinuation { continuation in
            self.repo.fetch()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
