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
    
    func testRegularTip() {
        // User enters a ₹100 bill
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹100")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹100")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹0")
        
        // user selects 10%
        screen.selectTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹110")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹110")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹10")

        // user selects 15%
        screen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹115")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹115")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹15")

        // user selects 20%
        screen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹120")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹20")

        // user selects 20%
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹30")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹20")

        // user selects 20%
        screen.selectDecementButton(numberOfTaps: 2)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹60")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹20")
    }
    
    func testCustomTipAndSplitBillBy2() {
      screen.enterBill(amount: 300)
      screen.selectTip(tip: .custom(value: 200))
      screen.selectIncrementButton(numberOfTaps: 1)
      XCTAssertEqual(screen.totalBillValueLabel.label, "₹500")
      XCTAssertEqual(screen.totalTipValueLabel.label, "₹200")
      XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹250")
    }
    
    func testResetButton() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        screen.doubleTapLogoview()
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹0")
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹0")
        XCTAssertEqual(screen.billInputViewTextField.label, "")
        XCTAssertEqual(screen.splitValueLabel.label, "1")
        XCTAssertEqual(screen.customTipButton.label, "Custom tip")
    }
}
