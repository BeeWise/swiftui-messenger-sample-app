//
//  InboxView.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 08.08.2023.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @State private var user = User.dummyUser
    
    var body: some View {
        self.setupContentView()
    }
    
    private func setupContentView() -> some View {
        NavigationStack {
            self.setupScrollView()
        }
    }
    
    private func setupScrollView() -> some View {
        ScrollView {
            self.setupActiveUsersView()
            self.setupChatsView()
        }
        .navigationDestination(for: User.self, destination: { user in
            ProfileView(user: user)
        })
        .fullScreenCover(isPresented: self.$showNewMessageView, content: {
            NewMessageView()
        })
        .toolbar {
            self.setupLeadingToolbarItem()
            self.setupTrailingToolbarItem()
        }
    }
    
    private func setupLeadingToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            HStack {
                self.setupAvatarView()
                
                Text("Chats")
                    .font(.title)
                    .fontWeight(.semibold)
            }
        }
    }
    
    private func setupAvatarView() -> some View {
        NavigationLink(value: self.user) {
            UserAvatarView(user: self.user, size: .xSmall)
        }
    }
    
    private func setupTrailingToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                self.showNewMessageView.toggle()
            } label: {
                Image(systemName: "square.and.pencil.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.black, Color(.systemGray5))
            }
        }
    }
    
    private func setupActiveUsersView() -> some View {
        return ActiveUsersView()
    }
    
    private func setupChatsView() -> some View {
        List {
            ForEach(0 ... 10, id: \.self) { message in
                InboxChatView().swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .frame(height: UIScreen.main.bounds.height - 64, alignment: .center)
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}

protocol InboxDisplayLogic: AnyObject {
    func displaySomething(viewModel: InboxModels.Something.ViewModel)
}
