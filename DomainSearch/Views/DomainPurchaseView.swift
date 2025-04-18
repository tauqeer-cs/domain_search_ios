//
//  DomainPurchaseView.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//

import SwiftUI

struct DomainPurchaseView: View {
    @StateObject private var viewModel: DomainDetailViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    
    init(domain: Domain) {
        _viewModel = StateObject(wrappedValue: DomainDetailViewModel(domain: domain))
    }
    
    @State private var years: Int = 1
    let domainName: String = "domainforsale.com"
    let registrationPrice: Int = 100
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    coordinator.navigateBack()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.leading)
                Spacer()
            }

            Spacer()
            Text(domainName)
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 100)
            

            if viewModel.isPurchased {
                Spacer()
                purchaseSuccessView
                Spacer()
            }
            else if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            }
            else {

                VStack(spacing: 20) {
                    VStack(spacing: 5) {
                        Text("Registration price")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        
                        Text("$\(registrationPrice)")
                            .font(.system(size: 70, weight: .bold))
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Years to register")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                if years > 1 {
                                    years -= 1
                                }
                            }) {
                                Image(systemName: "minus")
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            
                            Text("\(years) year\(years > 1 ? "s" : "")")
                                .frame(minWidth: 80)
                            
                            Button(action: {
                                years += 1
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                        }
                    }
                    
                    // Domain privacy
                    HStack {
                        Text("Domain privacy")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        Text("Included")
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Text("SSL certificate")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                        
                        Spacer()
                        
                        Text("Included")
                            .fontWeight(.medium)
                    }
                    
                    Divider()
                        .padding(.vertical)
                    
                    HStack {
                        Text("Total")
                            .font(.system(size: 30, weight: .bold))
                        
                        Spacer()
                        
                        Text("$\(registrationPrice * years)")
                            .font(.system(size: 30, weight: .bold))
                    }
                    
                    Button(action: {
                        viewModel.purchaseDomain()
                    }) {
                        Text("Purchase domain")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                Capsule()
                                    .fill(Color.black)
                            )
                    }
                    .padding(.top)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 0)
                )
                .padding()
                
            }

            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(UIColor.systemGray6))
    }
 
    private var purchaseSuccessView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Congratulations!")
                .font(.title)
                .fontWeight(.bold)
            
            Text("You have successfully purchased \(viewModel.domain.domain)")
                .multilineTextAlignment(.center)
                .font(.headline)
            
            Button(action: {
                coordinator.navigateBack()
            }) {
                Text("Return to Search")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
}
