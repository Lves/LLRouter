//
//  LLScreenId.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

/// Id protocol for all the screens
public protocol LLScreenId {
    associatedtype Destination: View
    var toView: Destination { get }
    var screenName: String { get }
}

extension NSNotification {
    static let RouteBackTo = Notification.Name("RouteBackTo")
}

public extension View {
    static var structName: String {
        return String(describing: self)
    }

    var structName: String {
        return type(of: self).structName
    }
}
