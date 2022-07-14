//
//  LLPageStack.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI

public class LLPageStack: ObservableObject {
    @Published public var pages: [String] = []
    public init(){}
}
