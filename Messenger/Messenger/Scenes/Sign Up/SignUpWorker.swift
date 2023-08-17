//
//  SignUpWorker.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit
import Combine

class SignUpWorker {
    var authenticationTask = TaskConfigurator.shared.authenticationTask()
    
    func signUp(email: String, password: String, fullname: String, subject: PassthroughSubject<User?, Error>) {
        self.authenticationTask.signUp(model: AuthenticationTaskModels.SignUp.Request(email: email, fullname: fullname, password: password), subject: subject)
    }
}
