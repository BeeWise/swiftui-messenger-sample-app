//
//  FirebaseService.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 16.08.2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

// MARK: - Authentication

class FirebaseService {
    static let shared = FirebaseService()
    
    private init() {
        
    }
    
    func currentUser() -> User? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return User(id: user.uid, fullname: nil, email: user.email)
    }
    
    func loginUser(email: String, password: String) async throws -> User? {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return try await self.fetchCurrentUser()
        } catch {
            print("DEBUG: Cannot log in user - error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func createUser(email: String, password: String, fullname: String) async throws -> User? {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await self.updateUser(email: email, fullname: fullname, id: result.user.uid)
            return try await self.fetchCurrentUser()
        } catch {
            print("DEBUG: Cannot create user - error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Cannot sign out user - error: \(error.localizedDescription)")
        }
    }
    
    private func updateUser(email: String, fullname: String, id: String) async throws {
        let user = User(id: nil, fullname: fullname, email: email, profileImageUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
}

// MARK: - User

extension FirebaseService {
    func fetchCurrentUser() async throws -> User? {
        guard let id = Auth.auth().currentUser?.uid else { return nil }
        let snapshot = try await Firestore.firestore().collection("users").document(id).getDocument()
        let user = try snapshot.data(as: User?.self)
        user?.id = id
        return user
    }
    
    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap { document in
            let user = try? document.data(as: User?.self)
            user?.id = document.documentID
            return user
        }
    }
}
