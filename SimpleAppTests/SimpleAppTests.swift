//
//  SimpleAppTests.swift
//  SimpleAppTests
//
//  Created by Jacob Hughes on 24/08/2020.
//  Copyright © 2020 MyUNiDAYS. All rights reserved.
//

import XCTest
@testable import SimpleApp

class SimpleAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherService() throws {
        
        let expectation = self.expectation(description: "Getting weather")
        
        let weatherService = WeatherService()
        _ = weatherService.getTodaysWeatherForecast().subscribe(
            onNext: { weatherForecast in
                XCTAssertTrue(weatherForecast.iconName.isEmpty == false)
                expectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: 10, handler: nil)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
