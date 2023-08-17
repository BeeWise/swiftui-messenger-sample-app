//
//  LoginView+Subviews.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 16.08.2023.
//

import Foundation
import SwiftUI

extension LoginView.Displayer {
    func setupSubviews() {
        self.setupLoginButtonModel()
        self.setupLoginButtonStyle()
    }
    
    private func setupLoginButtonModel() {
        var title = AttributedString("Login")
        title.font = .subheadline
        title.foregroundColor = .white
        
        let model = LoadingButton.Model()
        model.title = title
        model.isLoading = false
        model.isDisabled = false

        self.loginButtonModel = model
    }
    
    private func setupLoginButtonStyle() {
        let style = LoadingButton.Style()
        style.title = LoadingButton.TitleStyleModifier(fontWeight: .semibold, alignment: .center)
        style.content = LoadingButton.ContentStyleModifier(background: Color(.systemBlue), cornerRadius: 12)
        style.progress = LoadingButton.ProgressStyleModifier(color: .white)
        
        self.loginButtonStyle = style
    }
}
