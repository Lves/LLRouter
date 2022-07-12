//
//  LLScreen.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

public struct LLScreen<Content, ScreenId: LLScreenId> : View where Content : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var screenStack: LLScreenStack
    @StateObservedObject var router: LLRouter = LLRouter()
    
    let content: (LLRouter) -> Content
    let screenName: String
    
    public init(id screenId: ScreenId, @ViewBuilder _ content: @escaping (LLRouter) -> Content) {
        self.screenName = screenId.screenName
        self.content = content
    }
    
    public var body: some View {
        content(router)
            .background(
                NavigationLink(isActive: $router.isActive,
                               destination: {
                                   router.destination
                               },
                               label: {
                                   EmptyView()
                               })
            )
            .onDataChange(of: router.isBack) { newValue in
                presentationMode.wrappedValue.dismiss()
            }
            .onReceive(NotificationCenter.default
                        .publisher(for: NSNotification.RouteBackTo)) { (output) in
                if #available(iOS 15.0, macOS 12.0, *) {
                    guard let targetName = output.userInfo?[LLRouter.screenNameKey] as? String,
                          let targetIndex = screenStack.screens.firstIndex(where: {$0 == targetName}),
                          let index = screenStack.screens.firstIndex(where: {$0 == screenName}),
                          index >= targetIndex else { return }
                    router.isActive = false
                } else {
                    if output.userInfo?[LLRouter.screenNameKey] as? String == screenName {
                        router.isActive = false
                    }
                }
            }
                        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        if #available(iOS 15.0, macOS 12.0, *) {
            if screenStack.screens.contains(screenName) {
                guard let index = screenStack.screens.firstIndex(where: {$0 == screenName}) else { return }
                let startIndex = screenStack.screens.index(index, offsetBy: 1)
                screenStack.screens.removeSubrange(startIndex..<screenStack.screens.endIndex)
            } else {
                screenStack.screens.append(screenName)
            }
        }
    }
}
