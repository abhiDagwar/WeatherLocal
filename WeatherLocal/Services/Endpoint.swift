//
//  Endpoints.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 21/03/22.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    static func search(matching query: String) -> Endpoint {
        return Endpoint(
            path: "/geo/1.0/direct",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "appid", value: "be75b4f8c97dad04380bbf70c292dc5b")
            ]
        )
    }
    
    static func searchWeather(for lat: String, lon: String) -> Endpoint {
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
        return Endpoint(
            path: "/data/2.5/weather",
            queryItems: [
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: lon),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: "be75b4f8c97dad04380bbf70c292dc5b")
            ]
        )
    }

}
