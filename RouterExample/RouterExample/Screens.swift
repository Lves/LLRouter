//
//  Screens.swift
//  RouterExample
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI
import LLRouter

enum Screens {
    case home
    case secondary
    case third
}

extension Screens: LLScreenId {
    var screenName: String {
        switch self {
        case .home:
            return HomeScreen.structName
        case .secondary:
            return SecondaryScreen.structName
        case .third:
            return ThirdScreen.structName
        }
    }
    
    @ViewBuilder var toView: some View {
        switch self {
        case .home:
            HomeScreen()
        case .secondary:
            SecondaryScreen()
        case .third:
            ThirdScreen()
        }
    }
}
