//
//  NetworkClient.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 28/03/22.
//

import Foundation

protocol NetworkClientProtocol {
    func getGeoAddress(for location: String, completion: @escaping (GeoLocations?, Error?) -> Void)
    func getWeatherData(for lat: String, lon: String, completion: @escaping (WeatherData?, Error?) -> Void)
}

class NetworkClient: NetworkClientProtocol {
    private func getRequest<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type, handler: @escaping (T?, Error?) -> Void) {
        guard let url = endpoint.url else {
            return handler(nil, NetworkClientError.invalidUrl)
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    print("\(NetworkClientError.failedRequest.errorDescription! as String): \(error!.localizedDescription)")
                    handler(nil, NetworkClientError.failedRequest)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print(NetworkClientError.noData.errorDescription! as String)
                    handler(nil, NetworkClientError.noData)
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    print(NetworkClientError.invalidResponse.errorDescription! as String)
                    handler(nil, NetworkClientError.invalidResponse)
                }
                return
            }
            
            guard response.statusCode == 200 else {
                DispatchQueue.main.async {
                    print("\(NetworkClientError.failedRequest.errorDescription! as String): \(response.statusCode)")
                    handler(nil, NetworkClientError.failedRequest)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let parseData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    handler(parseData, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    print("\(NetworkClientError.invalidData.errorDescription! as String): \(error.localizedDescription)")
                    handler(nil, NetworkClientError.invalidData)
                }
            }
        }
        task.resume()
    }
    
    func getGeoAddress(for location: String, completion: @escaping (GeoLocations?, Error?) -> Void) {
        getRequest(.search(matching: location), responseType: GeoLocations.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getWeatherData(for lat: String, lon: String, completion: @escaping (WeatherData?, Error?) -> Void) {
        getRequest(.searchWeather(for: lat, lon: lon), responseType: WeatherData.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
