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
            LLScreen(id: Screens.home) { router in
                Button("To Secondary") {
                    router.push(to: Screens.secondary)
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}



struct SecondaryPage: View {
    var body: some View {
        LLScreen(id: Screens.secondary) { router in
            VStack {
                Button("To Third") {
                    router.push(to: Screens.third)
                }
                
                Button("Back") {
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
                    router.back()
                }
                
                Button("Back to root page") {
                    router.back(to: Screens.home)
                }
            }
        }
        .navigationBarTitle("Third", displayMode: .inline)
    }
}





struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
