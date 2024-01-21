//
//  MoviesStupManager.swift
//  MoviesTests
//
//  Created by mohamed salah on 20/01/2024.
//

import Foundation
import MovieModule

class BaseStubManager {
    var bundle: Bundle {
        .init(for: Self.self)
    }
}

class MoviesStubManager: BaseStubManager {
    
    static let shared: MoviesStubManager = .init()
    
    var moviesStub: MoviesListModel? {
        get throws {
            guard let bundlePath = bundle.path(forResource: "MoviesListStup", ofType: "json"),
                  let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else { return nil }
            let stub = try JSONDecoder().decode(MoviesListModel.self, from: jsonData)
            return stub
        }
    }
    
    var movieDetailsStub: Movie? {
        get throws {
            guard let bundlePath = bundle.path(forResource: "MoviesDetailsStup", ofType: "json"),
                  let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else { return nil }
            let stub = try JSONDecoder().decode(Movie.self, from: jsonData)
            return stub
        }
    }
}
