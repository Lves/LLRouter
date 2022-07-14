//
//  LLNavigationView.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

public struct LLNavigationView<Content> : View where Content : View {
    var pageStack: LLPageStack
    let content: Content
    
    public init(pageStack: LLPageStack? = nil, @ViewBuilder content: () -> Content) {
        if let pageStack = pageStack {
            self.pageStack = pageStack
        } else {
            self.pageStack = LLPageStack()
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
        .environmentObject(pageStack)
    }
}
