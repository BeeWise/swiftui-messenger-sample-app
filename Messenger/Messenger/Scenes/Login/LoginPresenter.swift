//
//  LoginPresenter.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit
import SwiftUI

protocol LoginPresentationLogic {
    func presentLoginLoadingState()
    func presentLoginNotLoadingState()
    
    func presentLoginSuccess(response: LoginModels.LoginSuccess.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var displayer: LoginDisplayLogic?
    
    func presentLoginLoadingState() {
        self.displayer?.displayLoginLoadingState()
    }
    
    func presentLoginNotLoadingState() {
        self.displayer?.displayLoginNotLoadingState()
    }
    
    func presentLoginSuccess(response: LoginModels.LoginSuccess.Response) {
        self.displayer?.displayLoginSuccess(viewModel: LoginModels.LoginSuccess.ViewModel(user: response.user))
    }
}
