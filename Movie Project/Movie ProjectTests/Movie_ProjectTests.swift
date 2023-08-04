//
//  Movie_ProjectTests.swift
//  Movie ProjectTests
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import XCTest
@testable import Movie_Project

final class Movie_ProjectTests: XCTestCase {

    func testMovieListingFromAPI() {
        let viewController = MovieListVC()
        let expectation = XCTestExpectation(description: "Recreation data received")
        viewController.getMovieListingFromAPI(page: "1")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(viewController.storeListing.count, 20)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

}
