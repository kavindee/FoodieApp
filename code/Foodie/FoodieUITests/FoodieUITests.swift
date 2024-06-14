//
//  FoodieUITests.swift
//  FoodieUITests
//
//  Created by kavin on BE 2567-06-12.
//

import XCTest

class FoodieUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testContentViewElements() throws {
        // Check if main elements are present
        XCTAssertTrue(app.staticTexts["Hi Mohan"].exists)
        XCTAssertTrue(app.images["foodie"].exists)
        XCTAssertTrue(app.staticTexts["New Meal"].exists)
        XCTAssertTrue(app.staticTexts["Reset Circle"].exists)
    }

    func testNavigateToProfileView() throws {
        // Tap the profile image to navigate to the profile view
        app.images["foodie"].tap()
        XCTAssertTrue(app.staticTexts["Profile Page"].exists)
    }

    func testAddNewMeal() throws {
        // Tap the "New Meal" button to open AddView
        app.staticTexts["New Meal"].tap()
        
        // Fill in the meal details
        app.textFields["name"].tap()
        app.textFields["name"].typeText("Burger")
        
        app.textFields["title"].tap()
        app.textFields["title"].typeText("Beef, Lettuce")
        
        app.images["plus"].tap() // Assuming the icon selection is handled
        
        // Save the meal
        app.staticTexts["Save"].tap()
        
        // Verify that the meal is added (this part depends on your implementation)
        XCTAssertTrue(app.staticTexts["Burger"].exists)
    }
}
