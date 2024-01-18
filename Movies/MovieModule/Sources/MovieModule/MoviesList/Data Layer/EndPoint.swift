//
//  File.swift
//  
//
//  Created by mohamed salah on 16/01/2024.
//

import Foundation
import NetworkLayer

public enum Endpoint: TargetType {
    case moviesList
    case movieDetails(id: Int)
    public var path: String {
        switch self {
        case .moviesList:
            return "/3/discover/movie"
        case .movieDetails(id: let movieId):
            return "/3/movie/\(movieId)"
            
        }
    }

    public var httpMethod: HttpMethod {
        switch self {
        case .moviesList, .movieDetails:
            return .get
        }
    }
}
