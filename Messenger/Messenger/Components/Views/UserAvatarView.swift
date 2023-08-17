//
//  UserAvatarView.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 09.08.2023.
//

import SwiftUI

enum UserAvatarViewSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
            case .xxSmall: return 24
            case .xSmall: return 32
            case .small: return 40
            case .medium: return 56
            case .large: return 64
            case .xLarge: return 80
        }
    }
}

struct UserAvatarView: View {
    let user: User
    let size: UserAvatarViewSize
    
    var body: some View {
        if let profileImageUrl = self.user.profileImageUrl {
            Image(profileImageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: self.size.dimension, height: self.size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: self.size.dimension, height: self.size.dimension)
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct UserAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatarView(user: User.dummyUser, size: .large)
    }
}
