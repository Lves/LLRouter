//
//  Pages.swift
//  RouterExample
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI
import LLRouter

enum Pages {
    case home
    case secondary
    case third
}

extension Pages: LLPageId {
    var pagenName: String {
        switch self {
        case .home:
            return HomePage.structName
        case .secondary:
            return SecondaryPage.structName
        case .third:
            return ThirdPage.structName
        }
    }
    
    @ViewBuilder var toView: some View {
        switch self {
        case .home:
            HomePage()
        case .secondary:
            SecondaryPage()
        case .third:
            ThirdPage()
        }
    }
}
