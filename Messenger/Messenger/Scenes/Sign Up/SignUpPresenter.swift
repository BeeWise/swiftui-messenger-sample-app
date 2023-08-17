//
//  SignUpPresenter.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol SignUpPresentationLogic {
    func presentSignUpLoadingState()
    func presentSignUpNotLoadingState()
    
    func presentSignUpSuccess(response: SignUpModels.SignUpSuccess.Response)
}

class SignUpPresenter: SignUpPresentationLogic {
    weak var displayer: SignUpDisplayLogic?
    
    func presentSignUpLoadingState() {
        self.displayer?.displaySignUpLoadingState()
    }
    
    func presentSignUpNotLoadingState() {
        self.displayer?.displaySignUpNotLoadingState()
    }
    
    func presentSignUpSuccess(response: SignUpModels.SignUpSuccess.Response) {
        self.displayer?.displaySignUpSuccess(viewModel: SignUpModels.SignUpSuccess.ViewModel(user: response.user))
    }
}
