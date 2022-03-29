//
//  URLValidationError.swift
//  WeatherLocal
//
//  Created by Siya Dagwar on 28/03/22.
//

import Foundation

enum NetworkClientError: Error {
    case invalidUrl
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

extension NetworkClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
             return NSLocalizedString(
                "URL is invalid.",
                comment: ""
             )
        case .invalidResponse:
            return NSLocalizedString(
               "Failed request from server.",
               comment: ""
            )
        case .noData:
            return NSLocalizedString(
               "No data returned from server.",
               comment: ""
            )
        case .failedRequest:
            return NSLocalizedString(
               "Unable to process server response.",
               comment: ""
            )
        case .invalidData:
            return NSLocalizedString(
               "Failure response from server.",
               comment: ""
            )
        }
    }
}
