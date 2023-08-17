//
//  SignUpInteractor.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit
import Combine

protocol SignUpBusinessLogic {
    func shouldUpdateEmail(request: SignUpModels.TextUpdate.Request)
    func shouldUpdateFullname(request: SignUpModels.TextUpdate.Request)
    func shouldUpdatePassword(request: SignUpModels.TextUpdate.Request)
    
    func shouldSignUpUser()
}

class SignUpInteractor: SignUpBusinessLogic {
    var presenter: SignUpPresentationLogic?
    var worker: SignUpWorker = SignUpWorker()
    
    private var email = ""
    private var fullname = ""
    private var password = ""
    
    private var isSigningUp = false
    
    private var onSignUpCancellables = Set<AnyCancellable>()
    
    func shouldUpdateEmail(request: SignUpModels.TextUpdate.Request) {
        self.email = request.text
    }
    
    func shouldUpdateFullname(request: SignUpModels.TextUpdate.Request) {
        self.fullname = request.text
    }
    
    func shouldUpdatePassword(request: SignUpModels.TextUpdate.Request) {
        self.password = request.text
    }
}

// MARK: - SignUp

extension SignUpInteractor {
    private func onSignUpSubject() -> PassthroughSubject<User?, Error> {
        let subject = PassthroughSubject<User?, Error>()
        subject.sink { [weak self] completion in
            switch completion {
                case .failure(let error): self?.onFailureSignUp(error: error); break
                case .finished: break
            }
            self?.onFinishSignUp()
        } receiveValue: { [weak self] user in
            self?.onSuccessSignUp(user: user)
        }.store(in: &self.onSignUpCancellables)
        return subject
    }
    
    private func onFinishSignUp() {
        self.isSigningUp = false
        self.presenter?.presentSignUpNotLoadingState()
    }
    
    private func onSuccessSignUp(user: User?) {
        self.presenter?.presentSignUpSuccess(response: SignUpModels.SignUpSuccess.Response(user: user))
    }
    
    private func onFailureSignUp(error: Error) {
        // Display error alert?
    }
    
    func shouldSignUpUser() {
        if !self.isSigningUp {
            self.isSigningUp = true
            self.presenter?.presentSignUpLoadingState()
            
            self.worker.signUp(email: self.email, password: self.password, fullname: self.fullname, subject: self.onSignUpSubject())
        }
    }
}
