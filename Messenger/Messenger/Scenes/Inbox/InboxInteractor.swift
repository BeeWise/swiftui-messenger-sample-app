//
//  InboxInteractor.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol InboxBusinessLogic {
    func shouldDoSomething(request: InboxModels.Something.Request)
}

class InboxInteractor: InboxBusinessLogic, InboxWorkerDelegate {
    var presenter: InboxPresentationLogic?
    var worker: InboxWorker?
    
    init() {
        self.worker = InboxWorker(delegate: self)
    }
    
    func shouldDoSomething(request: InboxModels.Something.Request) {
        self.presenter?.presentSomething(response: InboxModels.Something.Response(value: request.value))
    }
}
