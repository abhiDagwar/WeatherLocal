//
//  WeatherDataTest.swift
//  WeatherLocalTests
//
//  Created by Siya Dagwar on 30/03/22.
//

import XCTest
@testable import WeatherLocal

class WeatherDataTest: XCTestCase {

    private static let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM-dd-yyyy"
      return formatter
    }()
    
    var weather: WeatherData!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        if let path = Bundle.main.path(forResource: "WeatherData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //print(jsonResult)
                let decoder = JSONDecoder()
                weather = try! decoder.decode(WeatherData.self, from: data)
            } catch {
                   // handle error
                  print("Error parsing json file")
              }
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testDecodeTemp() throws {
        XCTAssertEqual(weather.main.temp, 282.55)
    }
    
    func testDecodeIcon() throws {
        XCTAssertEqual(weather.weather[0].icon, "01d")
    }
    
    func testDecodeDescription() throws {
        XCTAssertEqual(weather.weather[0].weatherDescription, "clear sky")
    }
    
    func testDecodeDate() throws {
        XCTAssertEqual(Self.dateFormatter.string(from: weather.date), Self.dateFormatter.string(from:Date()))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
