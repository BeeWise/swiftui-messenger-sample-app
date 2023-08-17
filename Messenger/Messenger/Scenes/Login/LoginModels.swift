//
//  LoginModels.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

enum LoginModels {
    enum TextUpdate {
        struct Request {
            let text: String
        }
    }
    
    enum LoginSuccess {
        struct Response {
            let user: User?
        }
        
        struct ViewModel {
            let user: User?
        }
    }
}
