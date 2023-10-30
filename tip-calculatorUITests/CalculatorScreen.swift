//
//  CalculatorScreen.swift
//  tip-calculatorUITests
//
//  Created by CS Prasad on 30/10/23.
//

import XCTest

class CalculatorScreen {
    private let app: XCUIApplication
    
    init(app: XCUIApplication!) {
        self.app = app
    }
    
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLable.rawValue]
    }
    
}
