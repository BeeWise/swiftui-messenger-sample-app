//
//  LoginView.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 08.08.2023.
//

import SwiftUI

struct LoginView: View {
    var interactor: LoginBusinessLogic
    @ObservedObject var displayer: LoginView.Displayer
    
    @State private var email = ""
    @State private var password = ""
    
    init() {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let displayer = LoginView.Displayer()
        
        presenter.displayer = displayer
        interactor.presenter = presenter
        
        self.interactor = interactor
        self.displayer = displayer
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                self.setupLogoImageView()
                self.setupTextFieldsContainerView()
                self.setupForgotPasswordButton()
                self.setupLoginButton()
                self.setupLoginSeparatorView()
                self.setupFacebookButton()
                Spacer()
                Divider()
                self.setupSignUpButton()
            }
        }
        .onAppear()
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
                self.interactor.shouldUpdateEmail(request: LoginModels.TextUpdate.Request(text: text))
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
                self.interactor.shouldUpdatePassword(request: LoginModels.TextUpdate.Request(text: text))
            }
    }
    
    private func setupForgotPasswordButton() -> some View {
        return Button {
            print("Forgot password")
        } label: {
            Text("Forgot password?")
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.top)
                .padding(.trailing, 16)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private func setupLoginButton() -> some View {
        return LoadingButton(model: self.displayer.loginButtonModel, style: self.displayer.loginButtonStyle) {
            self.interactor.shouldLoginUser()
        }
        .frame(height: 44)
        .padding(.trailing, 16)
        .padding(.leading, 16)
        .padding(.vertical)
    }
    
    private func setupLoginSeparatorView() -> some View {
        return HStack {
            Rectangle()
                .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 0.5)
            
            Text("OR")
                .font(.footnote)
                .fontWeight(.semibold)
            
            Rectangle()
                .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 0.5)
        }
        .foregroundColor(.gray)
    }
    
    private func setupFacebookButton() -> some View {
        return Button {
            
        } label: {
            HStack {
                Image("facebook_app_icon")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text("Continue with Facebook")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.top, 8)
    }
    
    private func setupSignUpButton() -> some View {
        return NavigationLink {
           SignUpView()
                .navigationBarBackButtonHidden()
        } label: {
            HStack(spacing: 4) {
                Text("Don't have an account?")
                Text("Sign Up")
                    .fontWeight(.semibold)
            }
            .font(.footnote)
        }
        .padding(.vertical)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
