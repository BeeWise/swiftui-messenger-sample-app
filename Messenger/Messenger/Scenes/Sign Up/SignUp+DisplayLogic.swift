//
//  SignUp+DisplayLogic.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 16.08.2023.
//

import Foundation
import SwiftUI

protocol SignUpDisplayLogic: AnyObject {
    func displaySignUpLoadingState()
    func displaySignUpNotLoadingState()
    
    func displaySignUpSuccess(viewModel: SignUpModels.SignUpSuccess.ViewModel)
}

extension SignUpView {
    class Displayer: ObservableObject, SignUpDisplayLogic {
        @Published var signUpButtonModel = LoadingButton.Model()
        @Published var signUpButtonStyle = LoadingButton.Style()
        
        init() {
            self.setupSubviews()
        }
        
        func displaySignUpLoadingState() {
            DispatchQueue.main.async {
                self.signUpButtonModel.isLoading = true
                self.signUpButtonModel.isDisabled = true
            }
        }
        
        func displaySignUpNotLoadingState() {
            DispatchQueue.main.async {
                self.signUpButtonModel.isLoading = false
                self.signUpButtonModel.isDisabled = false
            }
        }
        
        func displaySignUpSuccess(viewModel: SignUpModels.SignUpSuccess.ViewModel) {
            DispatchQueue.main.async {
                AuthenticationService.shared.currentUser = viewModel.user
            }
        }
    }
}
