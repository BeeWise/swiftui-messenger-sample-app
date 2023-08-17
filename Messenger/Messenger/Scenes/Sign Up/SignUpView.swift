//
//  SignUpView.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 08.08.2023.
//

import SwiftUI

struct SignUpView: View {
    var interactor: SignUpBusinessLogic
    @ObservedObject var displayer: SignUpView.Displayer
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    
    @Environment(\.dismiss) var dismiss
    
    init() {
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let displayer = SignUpView.Displayer()
        
        presenter.displayer = displayer
        interactor.presenter = presenter
        
        self.interactor = interactor
        self.displayer = displayer
    }
    
    var body: some View {
        VStack {
            Spacer()
            self.setupLogoImageView()
            self.setupTextFieldsContainerView()
            self.setupSignUpButton()
            Spacer()
            Divider()
            self.setupSignInButton()
        }
    }
    
    private func setupLogoImageView() -> some View {
        return Image("messenger_app_icon")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
            .padding()
    }
    
    private func setupTextFieldsContainerView() -> some View {
        return VStack {
            self.setupEmailTextField()
            self.setupFullnameTextField()
            self.setupPasswordTextField()
        }
    }
    
    private func setupEmailTextField() -> some View {
        return TextField("Enter your email", text: self.$email)
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .onChange(of: self.email) { text in
                self.interactor.shouldUpdateEmail(request: SignUpModels.TextUpdate.Request(text: text))
            }
    }
    
    private func setupFullnameTextField() -> some View {
        return TextField("Enter your fullname", text: self.$fullname)
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .onChange(of: self.fullname) { text in
                self.interactor.shouldUpdateFullname(request: SignUpModels.TextUpdate.Request(text: text))
            }
    }
    
    private func setupPasswordTextField() -> some View {
        return SecureField("Enter your password", text: self.$password)
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 16)
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .onChange(of: self.password) { text in
                self.interactor.shouldUpdatePassword(request: SignUpModels.TextUpdate.Request(text: text))
            }
    }
    
    private func setupSignUpButton() -> some View {
        return LoadingButton(model: self.displayer.signUpButtonModel, style: self.displayer.signUpButtonStyle) {
            self.interactor.shouldSignUpUser()
        }
        .frame(height: 44)
        .padding(.trailing, 16)
        .padding(.leading, 16)
        .padding(.vertical)
    }
    
    private func setupSignInButton() -> some View {
        return Button {
            self.dismiss()
        } label: {
            HStack(spacing: 4) {
                Text("Already have an account?")
                Text("Sign In")
                    .fontWeight(.semibold)
            }
            .font(.footnote)
        }
        .padding(.vertical)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
