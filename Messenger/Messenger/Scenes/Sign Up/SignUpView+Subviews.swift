//
//  SignUpView+Subviews.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 16.08.2023.
//

import Foundation
import SwiftUI

extension SignUpView.Displayer {
    func setupSubviews() {
        self.setupSignUpButtonModel()
        self.setupSignUpButtonStyle()
    }
    
    private func setupSignUpButtonModel() {
        var title = AttributedString("Sign Up")
        title.font = .subheadline
        title.foregroundColor = .white
        
        let model = LoadingButton.Model()
        model.title = title
        model.isLoading = false
        model.isDisabled = false
        
        self.signUpButtonModel = model
    }
    
    private func setupSignUpButtonStyle() {
        let style = LoadingButton.Style()
        style.title = LoadingButton.TitleStyleModifier(fontWeight: .semibold, alignment: .center)
        style.content = LoadingButton.ContentStyleModifier(background: Color(.systemBlue), cornerRadius: 12)
        style.progress = LoadingButton.ProgressStyleModifier(color: .white)
        
        self.signUpButtonStyle = style
    }
}
