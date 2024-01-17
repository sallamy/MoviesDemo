import Foundation
import NetworkLayer

protocol MoviesListRepositoryProtocol {
    func fetch() async throws -> MoviesListModel
}

final class MoviesListRepository: MoviesListRepositoryProtocol {

    private let clientService: NetworkService

    init(clientService: NetworkService) {
        self.clientService = clientService
    }

 
    func fetch() async throws -> MoviesListModel {
        try await self.clientService.request(Endpoint.moviesList, parameters: nil)
    }
}


enum Endpoint: TargetType {
    case moviesList


    var path: String {
        switch self {
        case .moviesList:
            return "3/discover/movie"
        }
    }

    var httpMethod: HttpMethod {
        switch self {
        case .moviesList:
            return .get
        }
    }
}
