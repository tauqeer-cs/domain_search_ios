//
//  NetworkError.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case unknown(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Error decoding data"
        case .serverError(let code):
            return "Server error: \(code)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}