//
//  AuthenticationService.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 16.08.2023.
//

import Foundation

class AuthenticationService {
    static let shared = AuthenticationService()
    
    @Published var currentUser: User?
    
    private init() {
        self.currentUser = FirebaseService.shared.currentUser()
        self.fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        Task { self.currentUser = try await FirebaseService.shared.fetchCurrentUser() }
    }
}
