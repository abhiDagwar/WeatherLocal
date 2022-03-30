//
//  WeatherDataViewModel.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 29/03/22.
//

import Foundation

class WeatherDataViewModel: NSObject {
    var networkClientProtocol: NetworkClientProtocol
    let networkClient = NetworkClient()
    
    let locationName = Box("Loading...")
    let state = Box("Loading...")
    let date = Box(" ")
    let icon = Box("") //No image
    let summary = Box(" ")
    let forcastSummary = Box(" ")
    let temp = Box("-")
    
    private let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMM d"
      return dateFormatter
    }()
    
    init(networkClientProtocol: NetworkClientProtocol = NetworkClient()) {
        self.networkClientProtocol = networkClientProtocol
    }
    
    func fetchWeatherDataForLocation(lat: String, lon: String) {
        networkClient.getWeatherData(for: lat, lon: lon) { [weak self] (weatherData, error) in
            guard
              let self = self,
              let weatherData = weatherData
            else {
              return
            }
            self.date.value = self.dateFormatter.string(from: weatherData.date)
            self.locationName.value = weatherData.name
            self.state.value = weatherData.sys.country
            self.icon.value = weatherData.weather[0].icon
            self.summary.value = weatherData.weather[0].main
            self.temp.value = "\(weatherData.main.temp)"
            self.forcastSummary.value = "\nSummary: \(weatherData.weather[0].weatherDescription)"
        }
    }
}
