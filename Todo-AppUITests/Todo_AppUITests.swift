//
//  Todo_AppUITests.swift
//  Todo-AppUITests
//
//  Created by Shamkhal Guliyev on 3.10.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import XCTest

class Todo_AppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.navigationBars["Todo List"].buttons["Add"].tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        textView.tap()
        textView.typeText("this is note")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"Geç\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["SAVE"].tap()
        app.alerts.buttons["Done"].tap()
        app.navigationBars.buttons["Todo List"].tap()
        
    }
}
