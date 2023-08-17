//
//  InboxWorker.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol InboxWorkerDelegate: AnyObject {
    
}

class InboxWorker {
    weak var delegate: InboxWorkerDelegate?
    
    init(delegate: InboxWorkerDelegate?) {
        self.delegate = delegate
    }
}
