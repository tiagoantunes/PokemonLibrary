//
//  DetailsViewUITests.swift
//  PokemonLibraryUITests
//
//  Created by Tiago Antunes on 03/03/2024.
//

import XCTest

final class DetailsViewUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testNavigation() throws {
        let collectionView = app.collectionViews.firstMatch.waitForExistence(timeout: 2)

        let firstCell = app.collectionViews.children(matching: .any).element(boundBy: 0)
        if firstCell.exists {
            firstCell.tap()
        }
    }

    func testNavBar() throws {
        try testNavigation()
        let navBar = app.navigationBars.element

        XCTAssert(navBar.exists)
    }

    func testImage() throws {
        try testNavigation()
        let image = app.images.element
        XCTAssert(image.exists)
    }
}
