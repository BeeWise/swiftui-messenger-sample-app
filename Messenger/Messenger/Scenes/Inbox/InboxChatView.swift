//
//  InboxChatView.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 08.08.2023.
//

import SwiftUI

struct InboxChatView: View {
    var body: some View {
        self.setupContentView()
    }
    
    private func setupContentView() -> some View {
        HStack(alignment: .top, spacing: 12) {
            self.setupAvatarView()
            self.setupTextContainerView()
            self.setupTimeView()
        }
        .frame(height: 72)
    }
    
    private func setupAvatarView() -> some View {
        UserAvatarView(user: User.dummyUser, size: .medium)
    }
    
    private func setupTextContainerView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            self.setupNameText()
            self.setupMessageText()
        }
    }
    
    private func setupNameText() -> some View {
        Text("First name Last name")
            .font(.subheadline)
            .fontWeight(.semibold)
    }
    
    private func setupMessageText() -> some View {
        Text("Test message now or today!! Test message now or today!! Test message now or today!!")
            .font(.subheadline)
            .foregroundColor(.gray)
            .lineLimit(2)
            .frame(maxWidth: UIScreen.main.bounds.width - 128, alignment: .leading)
    }
    
    private func setupTimeView() -> some View {
        HStack {
            Text("Yesterday")
            
            Image(systemName: "chevron.right")
        }
        .font(.footnote)
        .foregroundColor(.gray)
    }
}

struct InboxChatView_Previews: PreviewProvider {
    static var previews: some View {
        InboxChatView()
    }
}
