//
//  AppCoordinator.swift
//  DomainSearch
//
//  Created by Tauqeer on 18/04/25.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigateTo(_ route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
