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
                        Spacer()
                    }
                } else if viewModel.isLoading {
                    VStack {
                        Spacer()
                        Text("Search for a domain \(viewModel.searchText)...")
                            .font(.system(size: 24, weight: .medium))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        Spacer()
                    }
                } else {

                    if AppConstants.searchStartMinLength >= viewModel.searchText.count && viewModel.resultDomains.isEmpty {
                        Text("No result")
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

