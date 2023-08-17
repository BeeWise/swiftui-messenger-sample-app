//
//  LoginWorker.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit
import SwiftUI
import Combine

class LoginWorker {
    var authenticationTask = TaskConfigurator.shared.authenticationTask()
            
    func login(email: String, password: String, subject: PassthroughSubject<User?, Error>) {
        self.authenticationTask.login(model: AuthenticationTaskModels.Login.Request(email: email, password: password), subject: subject)
    }
}
