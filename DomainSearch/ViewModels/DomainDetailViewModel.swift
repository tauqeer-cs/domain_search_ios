//
//  DomainDetailViewModel.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//


import Foundation
import Combine

class DomainDetailViewModel: BaseViewModel {
    let domain: Domain
    @Published var isPurchased = false
    
    init(domain: Domain) {
        self.domain = domain
        super.init()
    }
    
    func purchaseDomain() {
        // Mock purchase process
        isLoading = true
        
        Task {
            // Simulate network delay
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            
            await MainActor.run {
                self.isLoading = false
                self.isPurchased = true
            }
        }
    }
}