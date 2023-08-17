//
//  LoginView+DisplayLogic.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 10.08.2023.
//

import Foundation
import SwiftUI

protocol LoginDisplayLogic: AnyObject {
    func displayLoginLoadingState()
    func displayLoginNotLoadingState()
    
    func displayLoginSuccess(viewModel: LoginModels.LoginSuccess.ViewModel)
}

extension LoginView {
    class Displayer: ObservableObject, LoginDisplayLogic {
        @Published var loginButtonModel = LoadingButton.Model()
        @Published var loginButtonStyle = LoadingButton.Style()
        
        init() {
            self.setupSubviews()
        }
        
        func displayLoginLoadingState() {
            DispatchQueue.main.async {
                self.loginButtonModel.isLoading = true
                self.loginButtonModel.isDisabled = true
            }
        }
        
        func displayLoginNotLoadingState() {
            DispatchQueue.main.async {
                self.loginButtonModel.isLoading = false
                self.loginButtonModel.isDisabled = false
            }
        }
        
        func displayLoginSuccess(viewModel: LoginModels.LoginSuccess.ViewModel) {
            DispatchQueue.main.async {
                AuthenticationService.shared.currentUser = viewModel.user
            }
        }
    }
}
