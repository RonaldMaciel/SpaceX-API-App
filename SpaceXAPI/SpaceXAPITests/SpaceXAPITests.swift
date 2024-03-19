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
        // given
        let expectation = expectation(description: "Fetched launches")
    
        let url = "http://yourserver.com/launches"
        
        // when
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
    
    func testFormatDate() throws {
        // given
        let date = "2024-03-18T22:08:00.000Z"
        
        // when
        let shortDate = formatDate(from: date, as: .shortDate, timeZone: "UTC")
        let longDate = formatDate(from: date, as: .longDate, timeZone: "UTC")
        let shortDateAndTime = formatDate(from: date, as: .shortDateAndTime, timeZone: "UTC")
        let longDateAndTime = formatDate(from: date, as: .longDateAndTime, timeZone: "UTC")
        let time = formatDate(from: date, as: .time, timeZone: "UTC")
        
        // then
        XCTAssertEqual(shortDate, "18 Mar 2024")
        XCTAssertEqual(longDate, "18 March 2024")
        XCTAssertEqual(shortDateAndTime, "18 Mar 2024, 22:08")
        XCTAssertEqual(longDateAndTime, "18 March 2024, 22:08")
        XCTAssertEqual(time, "22:08")
    }
}
