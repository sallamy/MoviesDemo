import Foundation
import NetworkLayer
import Combine

public protocol MovieDetailsRepositoryProtocol {
    func getDetials(with movieId: Int) -> AnyPublisher<Movie, Error>
}

public class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    private let clientService: NetworkService

    public init(clientService: NetworkService) {
        self.clientService = clientService
    }

    public func getDetials(with movieId: Int) -> AnyPublisher<Movie, Error> {
        self.clientService.request(Endpoint.movieDetails(id: movieId), parameters: nil)
    }
}



