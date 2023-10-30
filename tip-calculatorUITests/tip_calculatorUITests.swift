//
//  tip_calculatorUITests.swift
//  tip-calculatorUITests
//
//  Created by CS Prasad on 27/10/23.
//

import XCTest

final class tip_calculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValue() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹0")
    }
}
