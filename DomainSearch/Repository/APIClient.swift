//
//  APIClient.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//

import Combine
import Foundation

protocol APIClientProtocol {
    func getData<T: Decodable>(from endpoint: String,queryParams: [URLQueryItem]? ) async throws -> T
}


class APIClient: APIClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getData<T: Decodable>(from endpoint: String,queryParams: [URLQueryItem]? = nil) async throws -> T {
        guard var urlComponents = URLComponents(string: ApiConstants.baseUrl  + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        urlComponents.queryItems = queryParams
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(NSError(domain: "HTTPResponse", code: 0))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
