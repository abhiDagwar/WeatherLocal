//
//  Endpoints.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 21/03/22.
//

import Foundation

//enum Endpoints {
//    static let baseUrl = "api.openweathermap.org"
//    static let APIKey = "be75b4f8c97dad04380bbf70c292dc5b"
//    //https://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
//    case getGeoCodingAddressPath
//
//    var path: String {
//        switch self {
//        case .getGeoCodingAddressPath:
//            return "/geo/1.0/direct"
//        }
//    }
//
//    var url: URL {
//        return URL(string: path)!
//    }
//}

//static let APIKey = "be75b4f8c97dad04380bbf70c292dc5b"

enum Sorting: String {
    case numberOfStars = "stars"
    case numberOfForks = "forks"
    case recency = "updated"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
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
//    static func geoCoding(for location: String) -> Endpoint {
//        return Endpoint(
//            path: "geo/1.0/direct",
//            queryItems: [
//                URLQueryItem(name: "q", value: location),
//                URLQueryItem(name: "appid", value: "be75b4f8c97dad04380bbf70c292dc5b")
//            ]
//        )
//    }
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
