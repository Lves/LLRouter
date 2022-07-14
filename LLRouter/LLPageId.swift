//
//  LLPageId.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

/// Id protocol for all the pages
public protocol LLPageId {
    associatedtype Destination: View
    var toView: Destination { get }
    var pagenName: String { get }
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
