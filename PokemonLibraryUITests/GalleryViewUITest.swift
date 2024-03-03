//
//  GalleryViewUITest.swift
//  PokemonLibraryUITests
//
//  Created by Tiago Antunes on 03/03/2024.
//

import XCTest

final class GalleryViewUITest: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testNavBar() throws {
        let title = app.staticTexts["Pokemon List"]
        let navBar = app.navigationBars.element

        XCTAssert(navBar.exists)
        XCTAssert(title.waitForExistence(timeout: 2))
    }

    func testElementList() throws {
        let collectionView = app.collectionViews.firstMatch
        XCTAssert(collectionView.waitForExistence(timeout: 2))
    }

    func testListRow() throws {
        let collectionView = app.collectionViews.firstMatch

        let rowImage = collectionView.images.firstMatch
        XCTAssert(rowImage.waitForExistence(timeout: 2))
    }
}
