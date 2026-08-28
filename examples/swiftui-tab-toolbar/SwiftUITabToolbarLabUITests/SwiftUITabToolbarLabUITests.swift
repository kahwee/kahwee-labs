import XCTest

final class SwiftUITabToolbarLabUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testOpensBasicTabsDemo() throws {
        let app = XCUIApplication()
        app.launch()

        let basicTabs = app.staticTexts["Basic tabs"]
        XCTAssertTrue(basicTabs.waitForExistence(timeout: 3))
        basicTabs.tap()
        XCTAssertTrue(app.staticTexts["Home"].waitForExistence(timeout: 3))
    }
}
