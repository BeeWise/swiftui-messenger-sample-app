//
//  InboxStyle.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

class InboxStyle {
    static let shared = InboxStyle()
    
    var contentViewModel: ContentViewModel
    
    private init() {
        self.contentViewModel = ContentViewModel()
    }
    
    struct ContentViewModel {
        var backgroundColor = UIColor.white //ApplicationStyle.colors.white
    }
}
