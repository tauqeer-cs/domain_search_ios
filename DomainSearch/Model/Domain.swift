//
//  Domain.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//


struct Domain: Codable, Identifiable, Hashable {
    var id: String { domain }
    let domain: String
    let createDate: String
    let updateDate: String
    let country: String?
    let isDead: String
    let a: [String]?
    let ns: [String]?
    let cname: [String]?
    let mx: [MXRecord]?
    let txt: [String]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(domain)
    }
    
    static func == (lhs: Domain, rhs: Domain) -> Bool {
        return lhs.domain == rhs.domain
    }
    
    enum CodingKeys: String, CodingKey {
        case domain
        case createDate = "create_date"
        case updateDate = "update_date"
        case country
        case isDead
        case a = "A"
        case ns = "NS"
        case cname = "CNAME"
        case mx = "MX"
        case txt = "TXT"
    }
}


struct MXRecord: Codable, Hashable {
    let exchange: String
    let priority: Int
}


struct DomainSearchResponse: Codable {
    let domains: [Domain]
    let total: Int
    let time: String
    let nextPage: String?
    
    enum CodingKeys: String, CodingKey {
        case domains, total, time
        case nextPage = "next_page"
    }
}
