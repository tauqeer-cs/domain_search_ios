//
//  Route.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//


import Foundation

enum Route: Hashable {
    case domainDetail(Domain)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .domainDetail(let domain):
            hasher.combine(0) 
            hasher.combine(domain.id)
        }
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.domainDetail(let lhsDomain), .domainDetail(let rhsDomain)):
            return lhsDomain.id == rhsDomain.id
        }
    }
}

