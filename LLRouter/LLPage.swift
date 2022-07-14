//
//  LLPage.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

public struct LLPage<Content, PageId: LLPageId> : View where Content : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var pageStack: LLPageStack
    @StateObservedObject var router: LLRouter = LLRouter()
    
    let content: (LLRouter) -> Content
    let pagenName: String
    
    public init(id pageId: PageId, @ViewBuilder _ content: @escaping (LLRouter) -> Content) {
        self.pagenName = pageId.pagenName
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
                    guard let targetName = output.userInfo?[LLRouter.pageNameKey] as? String,
                          let targetIndex = pageStack.pages.firstIndex(where: {$0 == targetName}),
                          let index = pageStack.pages.firstIndex(where: {$0 == pagenName}),
                          index >= targetIndex else { return }
                    router.isActive = false
                } else {
                    if output.userInfo?[LLRouter.pageNameKey] as? String == pagenName {
                        router.isActive = false
                    }
                }
            }
                        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        if #available(iOS 15.0, macOS 12.0, *) {
            if pageStack.pages.contains(pagenName) {
                guard let index = pageStack.pages.firstIndex(where: {$0 == pagenName}) else { return }
                let startIndex = pageStack.pages.index(index, offsetBy: 1)
                pageStack.pages.removeSubrange(startIndex..<pageStack.pages.endIndex)
            } else {
                pageStack.pages.append(pagenName)
            }
        }
    }
}
