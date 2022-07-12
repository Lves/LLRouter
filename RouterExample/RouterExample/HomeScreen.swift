//
//  HomeScreen.swift
//  RouterExample
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI
import LLRouter

struct HomeScreen: View {
    var body: some View {
        LLNavigationView {
            LLScreen(id: Screens.home) { router in
                Button("Next") {
                    router.push(to: Screens.secondary)
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}



struct SecondaryScreen: View {
    var body: some View {
        LLScreen(id: Screens.secondary) { router in
            VStack {
                Button("Next") {
                    router.push(to: Screens.third)
                }
                
                Button("back") {
                    router.back()
                }
            }
        }
        .navigationBarTitle("Secondary", displayMode: .inline)
    }
}

struct ThirdScreen: View {
    var body: some View {
        LLScreen(id: Screens.third) { router in
            VStack {
                Button("Back to current page") {
                    router.back(to: Screens.secondary)
                }
                
                Button("Back to root page") {
                    router.back()
                }
            }
        }
        .navigationBarTitle("Third", displayMode: .inline)
    }
}





struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
