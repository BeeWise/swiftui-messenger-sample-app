//
//  LoginStyle.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit
import SwiftUI

class LoginStyle {
    static let shared = LoginStyle()
    
    var contentViewModel: ContentViewModel
    
    private init() {
        self.contentViewModel = ContentViewModel()
    }
    
    struct ContentViewModel {
        var backgroundColor = Color.white // ApplicationStyle.colors.white
    }
}
