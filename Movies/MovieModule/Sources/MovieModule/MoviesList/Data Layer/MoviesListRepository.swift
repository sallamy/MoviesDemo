import Foundation
import NetworkLayer
import Combine

public protocol MoviesListRepositoryProtocol {
    func fetch() -> AnyPublisher<MoviesListModel, APIError>
}

public class MoviesListRepository: MoviesListRepositoryProtocol {

    private let clientService: NetworkService

    public init(clientService: NetworkService) {
        self.clientService = clientService
    }

 
    public func fetch() ->  AnyPublisher<MoviesListModel, APIError> {
         self.clientService.request(Endpoint.moviesList, parameters: nil)
    }
}


