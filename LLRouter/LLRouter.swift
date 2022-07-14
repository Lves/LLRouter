//
//  LLRouter.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

/// Router: tools for routing to new page or back to previous page
public class LLRouter: ObservableObject {
    static let pageNameKey: String = "routePageName"
    /// Target view for routing
    var destination: AnyView? {
        didSet {
            isActive = destination != nil
        }
    }
    /// If it is true, will route to new page
    @Published var isActive: Bool = false
    /// Whether need to dimiss itself and back to previous page
    @Published var isBack: Bool = false

    public init() {}
    
    /// Back to specified page by page name
    /// - Parameter name: destination page name
    public func back(to name: String) {
        NotificationCenter.default.post(name: NSNotification.RouteBackTo,
                                        object: nil,
                                        userInfo: [LLRouter.pageNameKey : name])
    }
    
    /// Push to new page by Id
    /// - Parameter id: destination pageId
    public func push<T: LLPageId>(to id: T) {
        self.destination = AnyView(id.toView)
    }
    
    /// Push to Root page with environmentObject
    /// - Parameter model: environmentObject
    public func push<T, D>(root destination: D, with model: T) where T : ObservableObject, D : LLPageId {
        self.destination = AnyView(
            LLNavigationView {
                    destination.toView
                }
                .environmentObject(model)
        )
    }
    
    /// Back to the previous page
    public func back() {
        isBack = true
    }
    
    /// Back to the specified page by destination's pageId
    /// - Parameter id: Destination pageId
    public func back<T: LLPageId>(to id: T) {
        back(to: id.pagenName)
    }
}

