//
//  HomePage.swift
//  RouterExample
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI
import LLRouter

struct HomePage: View {
    var body: some View {
        LLNavigationView {
            LLPage(id: Pages.home) { router in
                Button("To Secondary") {
                    router.push(to: Pages.secondary)
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}


struct SecondaryPage: View {
    var body: some View {
        LLPage(id: Pages.secondary) { router in
            VStack {
                Button("To Third") {
                    router.push(to: Pages.third)
                }
                
                Button("Back") {
                    router.back()
                }
            }
        }
        .navigationBarTitle("Secondary", displayMode: .inline)
    }
}

struct ThirdPage: View {
    var body: some View {
        LLPage(id: Pages.third) { router in
            VStack {
                Button("Back to current page") {
                    router.back()
                }
                
                Button("Back to root page") {
                    router.back(to: Pages.home)
                }
            }
        }
        .navigationBarTitle("Third", displayMode: .inline)
    }
}
