//
//  DomainSearchViewModel.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//

import Foundation
import Combine

class DomainSearchViewModel : BaseViewModel {
    
    @Published var searchText: String = ""
    @Published var resultDomains: [Domain] = []
    @Published var isSearching: Bool = false
    
    private let domainRepository: DomainRepositoryProtocol
    private var searchTas: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    init(domainRepository: DomainRepositoryProtocol = DomainRepository() ) {
        self.domainRepository = domainRepository
        super.init()
        
        $searchText
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.debouncedSearch()
            }
            .store(in: &cancellables)
        
    }
    
    private func search() {
        searchTas?.cancel()
        
        guard searchText.count >= AppConstants.searchStartMinLength else {
            resultDomains = []
            isSearching = false
            return
        }
        
        isLoading = true
        errorMessage = nil
        isSearching = true
        
        
        Task {
            do {
                let response = try await self.domainRepository.searchDomains(query: self.searchText)
                await MainActor.run {
                    self.resultDomains = response.domains
                    self.isSearching = false
                    self.isLoading = false
                }
            }
            catch {
                await MainActor.run {
                    self.resultDomains = []
                    self.isLoading = false
                    self.showError(error)
                }
            }
        }
        
    }
    
    func debouncedSearch() {
        searchTas?.cancel()
        searchTas = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            
            if !Task.isCancelled {
                await MainActor.run {
                    search()
                }
            }
        }
    }
    
    deinit {
        searchTas?.cancel()
    }
}
