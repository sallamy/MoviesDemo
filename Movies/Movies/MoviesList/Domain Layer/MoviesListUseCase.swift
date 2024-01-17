//
//  SubmitEmailUseCase.swift
//  BanqueMisr-UAE
//
//  Created by mohamed salah on 11/04/2023.
//

import Foundation

// sourcery: AutoMockable
protocol MoviesListUseCaseInterface {
    func executeFetchData() async throws -> MoviesListModel?
}

final class MoviesListUseCase: MoviesListUseCaseInterface  {

    private let repo: MoviesListRepositoryProtocol

     init(repo: MoviesListRepositoryProtocol) {
         self.repo = repo
     }

    func executeFetchData() async throws -> MoviesListModel? {
        return try await self.repo.fetch()
    }

}
