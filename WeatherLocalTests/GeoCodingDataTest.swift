//
//  GeoCodingDataTest.swift
//  WeatherLocalTests
//
//  Created by Siya Dagwar on 30/03/22.
//

import XCTest
@testable import WeatherLocal

class GeoCodingDataTest: XCTestCase {

    var geoLocations: GeoLocations!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let path = Bundle.main.path(forResource: "GeoCoding", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //print(jsonResult)
                let decoder = JSONDecoder()
                geoLocations = try! decoder.decode(GeoLocations.self, from: data)
            } catch {
                   // handle error
                  print("Error parsing json file")
              }
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeName() throws {
        XCTAssertEqual(geoLocations[0].name, "London")
    }
    
    func testDecodeLocalName() throws {
        XCTAssertEqual(geoLocations[0].localNames!["mr"], "लंडन")
    }
    
    func testDecodeLatitute() throws {
        XCTAssertEqual(geoLocations[0].lat, 51.5073219)
    }
    
    func testDecodeLongitute() throws {
        XCTAssertEqual(geoLocations[0].lon, -0.1276474)
    }
    
    func testDecodeState() throws {
        XCTAssertEqual(geoLocations[0].state, "England")
    }
    
    func testDecodeCountry() throws {
        XCTAssertEqual(geoLocations[0].country, "GB")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
