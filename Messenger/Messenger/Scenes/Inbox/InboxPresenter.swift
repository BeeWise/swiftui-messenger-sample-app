//
//  InboxPresenter.swift
//  Messenger
//
//  Created by Bee Wise on 2023-08-08.
//  Copyright (c) 2023 Bee Wise Development S.R.L. All rights reserved.

import UIKit

protocol InboxPresentationLogic {
    func presentSomething(response: InboxModels.Something.Response)
}

class InboxPresenter: InboxPresentationLogic {
    weak var displayer: InboxDisplayLogic?
    
    func presentSomething(response: InboxModels.Something.Response) {
        self.displayer?.displaySomething(viewModel: InboxModels.Something.ViewModel(value: response.value))
    }
}
