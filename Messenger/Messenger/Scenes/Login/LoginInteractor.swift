//
//  LoginInteractor.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import SwiftUI
import UIKit
import Combine

protocol LoginBusinessLogic {
    func shouldUpdateEmail(request: LoginModels.TextUpdate.Request)
    func shouldUpdatePassword(request: LoginModels.TextUpdate.Request)
    
    func shouldLoginUser()
}

class LoginInteractor: LoginBusinessLogic {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker = LoginWorker()
    
    private var email = ""
    private var password = ""
    
    private var isLoggingIn = false
    
    private var onLoginCancellables = Set<AnyCancellable>()
            
    func shouldUpdateEmail(request: LoginModels.TextUpdate.Request) {
        self.email = request.text
    }
    
    func shouldUpdatePassword(request: LoginModels.TextUpdate.Request) {
        self.password = request.text
    }
}

// MARK: - Login

extension LoginInteractor {
    private func onLoginSubject() -> PassthroughSubject<User?, Error> {
        let subject = PassthroughSubject<User?, Error>()
        subject.sink { [weak self] completion in
            switch completion {
                case .failure(let error): self?.onFailureLogin(error: error); break
                case .finished: break
            }
            self?.onFinishLogin()
        } receiveValue: { [weak self] user in
            self?.onSuccessLogin(user: user)
        }.store(in: &self.onLoginCancellables)
        return subject
    }
    
    private func onFinishLogin() {
        self.isLoggingIn = false
        self.presenter?.presentLoginNotLoadingState()
    }
    
    private func onSuccessLogin(user: User?) {
        self.presenter?.presentLoginSuccess(response: LoginModels.LoginSuccess.Response(user: user))
    }
    
    private func onFailureLogin(error: Error) {
        // Display error alert?
    }
    
    func shouldLoginUser() {
        if !self.isLoggingIn {
            self.isLoggingIn = true
            self.presenter?.presentLoginLoadingState()
            
            self.worker.login(email: self.email, password: self.password, subject: self.onLoginSubject())
        }
    }
}
