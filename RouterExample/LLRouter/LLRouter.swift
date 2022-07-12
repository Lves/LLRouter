//
//  LLRouter.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

/// Router: tools for routing to new screen or back to previous screen
public class LLRouter: ObservableObject {
    static let screenNameKey: String = "routeScreenName"
    /// Target view for routing
    var destination: AnyView? {
        didSet {
            isActive = destination != nil
        }
    }
    /// If it is true, will route to new screen
    @Published var isActive: Bool = false
    /// Whether need to dimiss itself and back to previous screen
    @Published var isBack: Bool = false

    public init() {}
    
    /// Back to specified screen by screen name
    /// - Parameter name: destination screen name
    public func back(to name: String) {
        NotificationCenter.default.post(name: NSNotification.RouteBackTo,
                                        object: nil,
                                        userInfo: [LLRouter.screenNameKey : name])
    }
    
    /// Push to new screen by Id
    /// - Parameter id: destination ScreenId
    public func push<T: LLScreenId>(to id: T) {
        self.destination = AnyView(id.toView)
    }
    
    /// Push to Root screen with environmentObject
    /// - Parameter model: environmentObject
    public func push<T, D>(root destination: D, with model: T) where T : ObservableObject, D : LLScreenId {
        self.destination = AnyView(
            NavigationView {
                    destination.toView
                }
                .environmentObject(model)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
        )
    }
    
    /// Back to the previous page
    public func back() {
        isBack = true
    }
    
    /// Back to the specified screen by destination's ScreenId
    /// - Parameter id: Destination ScreenId
    public func back<T: LLScreenId>(to id: T) {
        back(to: id.screenName)
    }
}

