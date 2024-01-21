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
public protocol MovieDetailsUseCaseInterface {
    func executeFetchDetails(movieId: Int) async throws -> Movie?
}

public class MovieDetailsUseCase: MovieDetailsUseCaseInterface {
    private let repo: MovieDetailsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    public init(repo: MovieDetailsRepositoryProtocol) {
        self.repo = repo
    }

    public func executeFetchDetails(movieId: Int) async throws -> Movie? {
        return try await withCheckedThrowingContinuation { continuation in
            self.repo.getDetails(with: movieId).sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            } receiveValue: { response in
                continuation.resume(returning: response)
            }.store(in: &cancellables)
        }
    }
}
