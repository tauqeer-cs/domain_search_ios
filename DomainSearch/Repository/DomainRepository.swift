//
//  DomainRepository.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//

import Foundation

protocol DomainRepositoryProtocol {
    func searchDomains(query: String) async throws -> DomainSearchResponse
}

class DomainRepository: DomainRepositoryProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func searchDomains(query: String) async throws -> DomainSearchResponse {
        let quertyItem = [URLQueryItem(name: "domain", value: query)]
        return try await  apiClient.getData(from: "/domains/search", queryParams: quertyItem)
    }
    
}
