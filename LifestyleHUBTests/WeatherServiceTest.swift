//
//  WeatherServiceTest.swift
//  LifestyleHUBTests
//
//  Created by Иван Лукъянычев on 24.03.2024.
//

import XCTest
@testable import LifestyleHUB

final class WeatherServiceTest: XCTestCase {
    
    var sut: WeatherService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WeatherService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        let promise = expectation(description: "Result: success")
        
        sut.getWeather(ll: (44.34, 10.99)) { result in
            switch result {
            case .success(let data):
                do {
                    let _ = try JSONDecoder().decode(WeatherModel.self, from: data)
                    promise.fulfill()
                } catch {
                    XCTFail("Result: failed to decode")
                }
            case .failure(_):
                XCTFail("Result: error to get data")
            }
        }
        
        wait(for: [promise], timeout: 10)
    }
}
