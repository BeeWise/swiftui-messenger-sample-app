//
//  ActiveUsersView.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 08.08.2023.
//

import SwiftUI

struct ActiveUsersView: View {
    var body: some View {
        self.setupContentView()
    }
    
    private func setupContentView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(0 ... 10, id: \.self) { user in
                    VStack {
                        self.setupAvatarContainerView()
                        self.setupUsernameText()
                    }
                }
            }
            .padding()
        }
        .frame(height: 100)
    }
    
    private func setupAvatarContainerView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            self.setupAvatarView()
            self.setupActiveDotView()
        }
    }
    
    private func setupAvatarView() -> some View {
        UserAvatarView(user: User.dummyUser, size: .medium)
    }
    
    private func setupActiveDotView() -> some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 18, height: 18)
            
            Circle()
                .fill(Color(.systemGreen))
                .frame(width: 12, height: 12)
        }
    }
    
    private func setupUsernameText() -> some View {
        Text("Username")
            .font(.subheadline)
            .foregroundColor(.gray)
    }
}

struct ActiveUsersView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveUsersView()
    }
}
