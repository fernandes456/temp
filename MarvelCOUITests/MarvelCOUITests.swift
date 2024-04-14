//
//  MarvelCOUITests.swift
//  MarvelCOUITests
//
//  Created by Geraldo Fernandes on 03/04/24.
//

import XCTest

final class MarvelCOUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ui_AddOneHeroToFavorite() {
        
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.containing(.staticText, identifier:"3-D Man")/*@START_MENU_TOKEN@*/.buttons["favoriteCellButtonIdentifier"]/*[[".buttons[\"love\"]",".buttons[\"favoriteCellButtonIdentifier\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["Favoritos"].tap()
        collectionViewsQuery.cells["heroCellIdentifier"].children(matching: .other).element.tap()
        let text = app/*@START_MENU_TOKEN@*/.staticTexts["3-D Man"]/*[[".staticTexts[\"3-D Man\"]",".staticTexts[\"nameIdentifier\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(text.exists, "Not added to favorite")
        app/*@START_MENU_TOKEN@*/.buttons["favoriteButtonIdentifier"]/*[[".buttons[\"love\"]",".buttons[\"favoriteButtonIdentifier\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["MarvelCO.HeroDetailView"].buttons["Back"].tap()
    }
    
    func test_ui_AddHeroToFavoriteFromDetailScreen() {
        
        let app = XCUIApplication()
        app.launch()
        let element = app.collectionViews.cells.containing(.staticText, identifier:"A-Bomb (HAS)").children(matching: .other).element
        element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["nameIdentifier"]/*[[".staticTexts[\"A-Bomb (HAS)\"]",".staticTexts[\"nameIdentifier\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["favoriteButtonIdentifier"]/*[[".buttons[\"love\"]",".buttons[\"favoriteButtonIdentifier\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["MarvelCO.HeroDetailView"].buttons["Back"].tap()
        app.tabBars["Tab Bar"].buttons["Favoritos"].tap()
        element.tap()
        
        let text = app.staticTexts["A-Bomb (HAS)"]
        XCTAssertTrue(text.exists, "Not added to favorite")
        app/*@START_MENU_TOKEN@*/.buttons["favoriteButtonIdentifier"]/*[[".buttons[\"love\"]",".buttons[\"favoriteButtonIdentifier\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
