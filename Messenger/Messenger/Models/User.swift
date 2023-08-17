//
//  User.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 08.08.2023.
//

import Foundation

class User: Codable, Identifiable, Hashable, Equatable {
    var id: String?
    var fullname: String?
    var email: String?
    var profileImageUrl: String?
    
    init(id: String?, fullname: String? = nil, email: String? = nil, profileImageUrl: String? = nil) {
        self.id = id
        self.fullname = fullname
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.fullname)
        hasher.combine(self.email)
        hasher.combine(self.profileImageUrl)
    }
}

extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension User {
    static let dummyUser = User(id: UUID().uuidString, fullname: "John Doe", email: "john.doe@gmail.com", profileImageUrl: "facebook_app_icon")
}
