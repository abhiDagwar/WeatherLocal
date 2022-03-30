//
//  WeatherData.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 29/03/22.
//

import Foundation

// To parse the JSON, add this file to your project and do:
//
//   let weatherData = try? newJSONDecoder().decode(WeatherData.self, from: jsonData)

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherData = try? newJSONDecoder().decode(WeatherData.self, from: jsonData)

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    private static let dateFormatter: DateFormatter = {
      var formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter
    }()
    
    let weather: [Weather]
    let main: Main
    let dt: Int
    let sys: Sys
    let name: String
    
    var date: Date {
      //strip off the time
      let dateString = String(dt)
      //use current date if unable to parse
        return Self.dateFormatter.date(from: String(dateString.prefix(10))) ?? Date()
    }
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
