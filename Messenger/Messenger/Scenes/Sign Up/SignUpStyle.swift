//
//  SignUpStyle.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

class SignUpStyle {
    static let shared = SignUpStyle()
    
    var contentViewModel: ContentViewModel
    
    private init() {
        self.contentViewModel = ContentViewModel()
    }
    
    struct ContentViewModel {
        var backgroundColor = UIColor.white
    }
}
