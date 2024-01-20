//
//  MoviesTests.swift
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

final class MoviesListTests: XCTestCase {
    private var sut: MoviesListViewModel!
    private var usecaseMock: MoviesListUseCaseInterfaceMock!
    private var coordinatorMock: MoviesModuleCoordinatorProviderMock!
    private var cancellables: Set<AnyCancellable>!
    
    
    override func setUpWithError() throws {
        cancellables = .init()
        usecaseMock = .init()
        coordinatorMock = .init()
        sut = .init(useCase: usecaseMock, moviesModuleCoordinatorProvider: coordinatorMock)
    }
    
    override func tearDownWithError() throws {
        cancellables = nil
        usecaseMock = nil
        sut = nil
        coordinatorMock = nil
    }
    
    
    func testLoadMoviesSucceeds() throws {
        
        guard let stub = try! MoviesStubManager.shared.moviesStub else {
            return      XCTFail("Failed to load  Response stub from json file.")
        }
        usecaseMock.given(.executeFetchData(willReturn: stub))
        
        let exp = expectation(description: "response")
        
        sut.moviesListObserver.dropFirst().sink { response  in
            
            XCTAssertEqual(response.count, 7, "Response should have 7 objects")
            exp.fulfill()
        }.store(in: &cancellables)
        Task { await sut.fetchMovies()}
        
        waitForExpectations(timeout: 4) { (error) in
            if error != nil {
                XCTFail("Did not fulfill expectations")
            }
        }
        
        
        usecaseMock.verify(.executeFetchData())
    }
    
    func testLoadMoviesFailed() throws {
        let error = APIError.decodingFailed
        usecaseMock.given(.executeFetchData(willThrow: error))
        
        let exp = expectation(description: "errorMessage")
        sut.errorObserver.sink { (error) in
            
            XCTAssertEqual(error, APIError.decodingFailed, "Error Decoding")
            exp.fulfill()
        }.store(in: &cancellables)
        
        Task { await sut.fetchMovies()}
        
        waitForExpectations(timeout: 2) { (error) in
            if error != nil {
                XCTFail("Did not fulfill expectations")
            }
        }
    }
    
    func testRouteToMovieDetails() throws {
        
        guard let stub = try MoviesStubManager.shared.moviesStub else {
            return      XCTFail("Failed to load  Response stub from json file.")
        }
        usecaseMock.given(.executeFetchData(willReturn: stub))
        let exp = expectation(description: "response")
        
        sut.moviesListObserver.dropFirst().sink { response  in
                exp.fulfill()
        }.store(in: &cancellables)
        
        Task { await sut.fetchMovies()}
        
        waitForExpectations(timeout: 2) { (error) in
            if error != nil {
                XCTFail("Did not fulfill expectations")
            }
        }
        sut.selectedIndex.send(1)
        coordinatorMock.verify(.navigateToDetailsViewController(movieId: .any))
    }
}
