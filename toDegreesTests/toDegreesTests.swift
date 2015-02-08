//
//  toDegreesTests.swift
//  toDegreesTests
//
//  Created by Matthew Curtner on 12/31/14.
//  Copyright (c) 2014 Matthew Curtner. All rights reserved.
//

import UIKit
import XCTest
import toDegrees

class toDegreesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFahrenheitToCelsius() {
        let vc = ViewController()
        
        XCTAssertEqual(vc.convertFahrenheitToCelsius(fahrenheit: "32"), Float(0.0), "32 F is equal to 0 C")
        
//        XCTAssertEqual(Float(31.1), vc.convertFahrenheitToCelsius(fahrenheit: "88"), "Should Pass")
//        XCTAssertEqual(Float(-9), vc.convertFahrenheitToCelsius(fahrenheit: "15"), "Should Pass")
//        XCTAssertEqual(Float(18), vc.convertFahrenheitToCelsius(fahrenheit: "64"), "Should Pass")
//        
//        XCTAssertNotEqual(Float(32), vc.convertFahrenheitToCelsius(fahrenheit: "45"), "Should Fail")
//        XCTAssertNotEqual(Float(-10), vc.convertFahrenheitToCelsius(fahrenheit: "16"), "Should Fail")
//        XCTAssertNotEqual(Float(-15), vc.convertFahrenheitToCelsius(fahrenheit: "23"), "Should Fail")
//        XCTAssertNotEqual(Float(37), vc.convertFahrenheitToCelsius(fahrenheit: "101"), "Should Fail")
    }
    
//    func testCelsiusToFahrenheit() {
//        let vc = ViewController()
//        
//        XCTAssertEqual(32, vc.convertCelsiusToFahrenheit(celsius: 0), "32 F is equal to 0")
//        XCTAssertEqual(88, vc.convertCelsiusToFahrenheit(celsius: 31), "32 F is equal to 0")
//        XCTAssertEqual(16, vc.convertCelsiusToFahrenheit(celsius: -9), "32 F is equal to 0")
//        XCTAssertEqual(64, vc.convertCelsiusToFahrenheit(celsius: 18), "32 F is equal to 0")
//
//        XCTAssertNotEqual(32, vc.convertCelsiusToFahrenheit(celsius: 45), "Should Fail")
//        XCTAssertNotEqual(-10, vc.convertCelsiusToFahrenheit(celsius: 88), "Should Fail")
//        XCTAssertNotEqual(-15, vc.convertCelsiusToFahrenheit(celsius: 10), "Should Fail")
//        XCTAssertNotEqual(37, vc.convertCelsiusToFahrenheit(celsius: 101), "Should Fail")
//    }
    
}
