//
//  LLScreenStack.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

public class LLScreenStack: ObservableObject {
    @Published public var screens: [String] = []
    public init(){}
}
