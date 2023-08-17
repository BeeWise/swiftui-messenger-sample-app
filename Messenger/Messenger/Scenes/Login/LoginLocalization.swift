//
//  LoginLocalization.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

class LoginLocalization {
    static let shared = LoginLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
            title = "Login.scene.title"
    }
    
    func title() -> String { "LocalizedKey.title.localized()" }
}
