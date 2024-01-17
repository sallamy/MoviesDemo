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
    public var path: String {
        switch self {
        case .moviesList:
            return "/3/discover/movie"
        }
    }

    public var httpMethod: HttpMethod {
        switch self {
        case .moviesList:
            return .get
        }
    }
}
