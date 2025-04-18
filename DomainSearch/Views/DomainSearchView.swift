//
//  DomainSearchView.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//

import SwiftUI

struct DomainSearchView: View {
    
    @StateObject private var viewModel = DomainSearchViewModel()
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Group {
                if !viewModel.isSearching && viewModel.searchText.isEmpty {
                    VStack {
                        Spacer()
                        Text("Start searching by typing a domain name in the search bar above.")
                            .multilineTextAlignment(.center)
                            .padding(.bottom,25)
                        Spacer()
                    }
                }
                else if viewModel.isLoading {
                    VStack {
                        Spacer()
                        Text("Search for a domain...")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.bottom ,24)
                        Spacer()
                        
                    }
                }
                else if let errorMessage = viewModel.errorMessage, viewModel.isSearching {
                   errorView(message: errorMessage)
                }
                else {

                    if AppConstants.searchStartMinLength >= viewModel.searchText.count && viewModel.resultDomains.isEmpty {
                        Text("No result")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.gray.opacity(0.5))
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(viewModel.resultDomains) { domain in
                                    DomainRowView(domain: domain)
                                        .onTapGesture {
                                            coordinator.navigateTo(.domainDetail(domain))
                                        }
                                }
                            }
                            .frame(alignment: .leading)
                            .padding(.top)
                        }
                        .background(Color(UIColor.systemGray6))
                    }
                }
            }
            .navigationTitle("Domain Search")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .domainDetail(let domain):
                    DomainPurchaseView(domain: domain)
                        .environmentObject(coordinator)
                }
            }
        }
        .environmentObject(coordinator)
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Error")
                .font(.title)
                .fontWeight(.bold)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Try Again") {
                viewModel.debouncedSearch()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

#Preview {
    DomainSearchView()
}

struct DomainRowView: View {
    let domain: Domain
    
    var body: some View {
        HStack {
            Text(domain.domain)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.leading)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

