//
//  LLNavigationView.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

public struct LLNavigationView<Content> : View where Content : View {
    var screenStack: LLScreenStack
    let content: Content
    
    public init(screenStack: LLScreenStack? = nil, @ViewBuilder content: () -> Content) {
        if let screenStack = screenStack {
            self.screenStack = screenStack
        } else {
            self.screenStack = LLScreenStack()
        }
        self.content = content()
    }
    
    public var body: some View {
        NavigationView {
            content
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .environmentObject(screenStack)
    }
}
