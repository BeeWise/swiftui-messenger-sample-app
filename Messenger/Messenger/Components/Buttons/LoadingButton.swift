//
//  LoadingButton.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 10.08.2023.
//

import SwiftUI

struct LoadingButton: View {
    class Model: ObservableObject {
        @Published var title: AttributedString = AttributedString()
        @Published var isLoading: Bool = false
        @Published var isDisabled: Bool = false
    }
    
    class Style: ObservableObject {
        @Published var content: ContentStyleModifier = ContentStyleModifier()
        @Published var title: TitleStyleModifier = TitleStyleModifier()
        @Published var progress: ProgressStyleModifier = ProgressStyleModifier()
    }
    
    @ObservedObject var model: Model
    @ObservedObject var style: Style
    
    var action: (() -> Void)?
    
    var body: some View {
        self.setupContentView()
    }
    
    @ViewBuilder func setupContentView() -> some View {
        VStack {
            Button {
                self.action?()
            } label: {
                if self.model.isLoading {
                    self.setupProgressView()
                } else {
                    self.setupTitle()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .disabled(self.model.isDisabled)
        }
        .modifier(self.style.content)
    }
    
    @ViewBuilder func setupProgressView() -> some View {
        ProgressView()
            .modifier(self.style.progress)
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder func setupTitle() -> some View {
        Text(self.model.title)
            .modifier(self.style.title)
            .frame(maxWidth: .infinity)
    }
}

extension LoadingButton {
    struct TitleStyleModifier: ViewModifier {
        var fontWeight: Font.Weight?
        var alignment: Alignment = .center
        
        var padding: EdgeInsets = EdgeInsets()
        
        func body(content: Content) -> some View {
            content
                .fontWeight(self.fontWeight)
                .padding(self.padding)
                .frame(maxWidth: .infinity, alignment: self.alignment)
        }
    }
    
    struct ContentStyleModifier: ViewModifier {
        var background: Color = .white
        var cornerRadius: CGFloat = CGFloat.zero
        
        func body(content: Content) -> some View {
            content
                .background(self.background)
                .cornerRadius(self.cornerRadius)
        }
    }
    
    struct ProgressStyleModifier: ViewModifier {
        var color: Color = .white
        
        func body(content: Content) -> some View {
            content
                .tint(self.color)
        }
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButton(model: self.model(), style: self.style(), action: {
            print("Action")
        })
        .frame(height: 44)
        .padding()
    }
    
    static func model() -> LoadingButton.Model {
        var title = AttributedString("Title")
        title.foregroundColor = .white
        title.font = .subheadline
                
        let model = LoadingButton.Model()
        model.title = title
        model.isLoading = false
        model.isDisabled = false
        return model
    }
    
    static func style() -> LoadingButton.Style {
        let style = LoadingButton.Style()
        style.title = LoadingButton.TitleStyleModifier(fontWeight: .semibold, alignment: .center)
        style.content = LoadingButton.ContentStyleModifier(background: Color(.systemBlue), cornerRadius: 12)
        style.progress = LoadingButton.ProgressStyleModifier(color: .white)
        return style
    }
}
