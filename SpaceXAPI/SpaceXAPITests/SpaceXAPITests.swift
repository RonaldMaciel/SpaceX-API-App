//
//  SpaceXAPITests.swift
//  SpaceXAPITests
//
//  Created by Ronald on 16/03/24.
//

import XCTest
@testable import SpaceXAPI

final class SpaceXAPITests: XCTestCase {

    let apiClient = MockLaunchesService()

    func testAPISuccess() {
        let expectation = expectation(description: "Fetched launches")
    
        let url = "http://yourserver.com/launches"
        
        apiClient.fetchLaunches(url: url) { result in
            switch result {
            case .success(let data):
                let launches = data
                print(launches)
                XCTAssertEqual(launches.isEmpty, false)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testInvalidAPIURLRequest() {
        let expectation = expectation(description: "Throw an Error for invalid URL")
        
        let url = "http://yourserver.com/invalid"
        
        apiClient.fetchLaunches(url: url) { result in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "URL does not exist.")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
