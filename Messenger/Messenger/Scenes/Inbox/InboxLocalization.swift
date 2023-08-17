//
//  InboxLocalization.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

class InboxLocalization {
    static let shared = InboxLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
            title = "Inbox.scene.title"
    }
    
    func title() -> String { "LocalizedKey.title.localized()" }
}
