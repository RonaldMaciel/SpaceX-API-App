//
//  SpaceXAPIUITests.swift
//  SpaceXAPIUITests
//
//  Created by Ronald on 16/03/24.
//

import XCTest

final class SpaceXAPIUITests: XCTestCase {
    
    struct AccessibilityIdentifier {
        static let missionName = "missionName"
        static let dateTime = "dateTime"
        static let rocketNameType = "rocketNameType"
        static let days = "days"
        static let missionNameStatic = "missionNameStatic"
        static let dateTimeStatic = "dateTimeStatic"
        static let rocketNameTypeStatic = "rocketNameTypeStatic"
        static let daysStatic = "daysStatic"
    }
    
    struct TestFailureMessage {
        static let missionNameNotDisplayed = "Mission name is not displayed"
        static let dateTimeNotDisplayed = "Date is not displayed"
        static let rocketNameTypeNotDisplayed = "Rocket name and type are not displayed"
        static let daysNotDisplayed = "Days is not displayed"
    }
    
    override func setUpWithError() throws {

        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testDetailLabels() throws {

        let app = XCUIApplication()
        app.launch()
        
        let missionNameLabel = app.staticTexts[AccessibilityIdentifier.missionName]
        XCTAssertTrue(missionNameLabel.exists)
        
        let missionNameLabelStatic = app.staticTexts[AccessibilityIdentifier.missionNameStatic]
        XCTAssertTrue(missionNameLabelStatic.exists)
        
        let dateTimeLabel = app.staticTexts[AccessibilityIdentifier.dateTime]
        XCTAssertTrue(dateTimeLabel.exists)
        
        let dateTimeLabelStatic = app.staticTexts[AccessibilityIdentifier.dateTimeStatic]
        XCTAssertTrue(dateTimeLabelStatic.exists)
        
        let rocketNameTypeLabel = app.staticTexts[AccessibilityIdentifier.rocketNameType]
        XCTAssertTrue(rocketNameTypeLabel.exists)
       
        let rocketNameTypeLabelStatic = app.staticTexts[AccessibilityIdentifier.rocketNameTypeStatic]
        XCTAssertTrue(rocketNameTypeLabelStatic.exists)
       
        let daysLabel = app.staticTexts[AccessibilityIdentifier.days]
        XCTAssertTrue(daysLabel.exists)
        
        let daysLabelStatic = app.staticTexts[AccessibilityIdentifier.daysStatic]
        XCTAssertTrue(daysLabelStatic.exists)
    }
}
