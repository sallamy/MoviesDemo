//
//  File.swift
//  
//
//  Created by mohamed salah on 16/01/2024.
//

import Foundation
import Combine

public protocol NetworkService {
     func request<T: Decodable>(_ endpoint: TargetType, parameters: Encodable?) -> AnyPublisher<T, Error>
}

public class NetworkManager: NetworkService {
    private let baseURL: String

    public init(baseURL: String = "") {
        self.baseURL = baseURL
    }

    public func request<T: Decodable>(_ endpoint: TargetType, parameters: Encodable? = nil) -> AnyPublisher<T, Error> {
            guard let url = URL(string: baseURL + endpoint.path) else {
                return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
            }
            var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("en", forHTTPHeaderField: "X-Locale")
        urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YWQ0M2E0MDVjNzBmYzNiNjVmYTBjNThmZTc0ZjcwMyIsInN1YiI6IjVmYTdjMDU2ZTZkM2NjMDAzZTFkYmE2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SdVFsU8eJgNvjKib3L1Li6hl_c_x-PpRWEhx__vnaL8", forHTTPHeaderField: "Authorization")
        
            if let parameters = parameters {
               
                do {
                    let jsonData = try JSONEncoder().encode(parameters)
                    urlRequest.httpBody = jsonData
                } catch {
                    return Fail(error: APIError.requestFailed("Encoding parameters failed.")).eraseToAnyPublisher()
                }
            }
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { (data, response) -> Data in
                    if let httpResponse = response as? HTTPURLResponse,
                       (200..<300).contains(httpResponse.statusCode) {
                        return data
                    } else {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                        throw APIError.requestFailed("Request failed with status code: \(statusCode)")
                    }
                }
                .decode(type: T.self, decoder: JSONDecoder())
                
                .eraseToAnyPublisher()
        }
}
