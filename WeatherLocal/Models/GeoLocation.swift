//
//  GeoLocation.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 21/03/22.
//

import Foundation

// MARK: - GeoCoding
struct GeoLocation: Codable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

typealias GeoLocations = [GeoLocation]


let location1 = GeoLocation(name: "Nagpur", localNames: ["en":"Nagpur", "mr":"नागपूर शहर तालुका", "hi":"नागपुर"], lat: 21.1498134, lon: 79.0820556, country: "IN", state: "Maharashtra")
let location2 = GeoLocation(name: "Nagpur", localNames: [:], lat: 23.2896623, lon: 82.352432, country: "IN", state: "Chhattisgarh")
let location3 = GeoLocation(name: "Nagpur", localNames: ["pa":"ਨਾਗਪੁਰ","hi":"नागपुर"], lat: 16.3650736, lon: 78.285935, country: "IN", state: "Telangana")
let location4 = GeoLocation(name: "Nagpur", localNames: ["pa":"ਨਾਗਪੁਰ","hi":"नागपुर"], lat: 17.8601216, lon: 79.5325009, country: "IN", state: "Telangana")
let location5 = GeoLocation(name: "Wardha", localNames: ["mr":"वर्धा","ta":"வர்தா","hi":"वर्धा"], lat: 20.7464941, lon: 78.5997922, country: "IN", state: "Maharashtra")
let location6 = GeoLocation(name: "Amravati", localNames: ["ur":"امراوتی","mr":"अमरावती","pa":"ਅਮਰਾਵਤੀ","en":"Amravati","ml":"അമരാവതി","hi":"अमरावती"], lat: 20.9316219, lon: 77.7588455, country: "IN", state: "Maharashtra")
let location7 = GeoLocation(name: "Amaravati", localNames: ["hi":"अमरावती"], lat: 16.5096679, lon: 80.5184535, country: "IN", state: "Andhra Pradesh")


let locations: [GeoLocation] = [location1, location2, location3, location4, location5, location6, location7]
