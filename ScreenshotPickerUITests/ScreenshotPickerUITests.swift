//
//  ScreenshotPickerUITests.swift
//  ScreenshotPickerUITests
//
//  Created by Yevgeniy Vasylenko on 7/5/17.
//  Copyright © 2017 Yevgeniy Vasylenko. All rights reserved.
//

import XCTest

class ScreenshotPickerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        addUIInterruptionMonitor(withDescription: "“ScreenshotPicker” Would Like to Access Your Photos") { (alert) -> Bool in
            alert.buttons["OK"].tap()
            return true
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.buttons["Pick screenshot"].tap()
        app.tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        app.navigationBars["ScreenshotPicker.FullImageView"].buttons["Done"].tap()
        let testImage = app.images["test"]
        XCTAssert(testImage.exists)
        // XCUI tests - how to get view by acessibilityIdentifier
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
}
