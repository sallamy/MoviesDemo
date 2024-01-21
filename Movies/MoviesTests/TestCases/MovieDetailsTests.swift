//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by mohamed salah on 16/01/2024.
//

//
//  MovieDetailsTests.swift
//  MoviesTests
//
//  Created by mohamed salah on 16/01/2024.
//

import XCTest
@testable import Movies
import DependenciesModule
import MovieModule
import NetworkLayer
import SwiftyMocky
import Combine

final class MovieDetailsTests: XCTestCase {
    private var sut: MovieDetailsViewModel!
    private var usecaseMock: MovieDetailsUseCaseInterfaceMock!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        cancellables = .init()
        usecaseMock = .init()
        sut = .init(useCase: usecaseMock)
    }
    
    override func tearDownWithError() throws {
        cancellables = nil
        usecaseMock = nil
        sut = nil
    }
    
    func testLoadMovieDetailsSucceed() throws {
        guard let stub = try MoviesStubManager.shared.movieDetailsStub else {
            return XCTFail("Failed to load Response stub from json file.")
        }
        usecaseMock.given(.executeFetchDetails(movieId: .any, willReturn: stub))
        
        let exp = expectation(description: "response")
        
        sut.movieDetailsObserver.sink { response in
            XCTAssertNotNil(response)
            exp.fulfill()
        }.store(in: &cancellables)
        Task { await sut.fetchMovieDetails(movieId: 1) }
        
        waitForExpectations(timeout: 2) { error in
            if error != nil {
                XCTFail("Did not fulfill expectations")
            }
        }
        usecaseMock.verify(.executeFetchDetails(movieId: .any))
    }
    
    func testLoadMoviesFailed() {
        let error = APIError.decodingFailed
        usecaseMock.given(.executeFetchDetails(movieId: .any, willThrow: error))
        
        let exp = expectation(description: "errorMessage")
        sut.errorObserver.sink { error in
            XCTAssertEqual(error, APIError.decodingFailed, "Error Decoding")
            exp.fulfill()
        }.store(in: &cancellables)
        
        Task { await sut.fetchMovieDetails(movieId: 1) }
        
        waitForExpectations(timeout: 2) { error in
            if error != nil {
                XCTFail("Did not fulfill expectations")
            }
        }
    }
}
