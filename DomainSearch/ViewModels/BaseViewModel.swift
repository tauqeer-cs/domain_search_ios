//
//  BaseViewModel.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func showError(_ error: Error) {
        if let networkError = error as? NetworkError {
            errorMessage = networkError.message
        } else {
            errorMessage = error.localizedDescription
        }
    }
    
}
