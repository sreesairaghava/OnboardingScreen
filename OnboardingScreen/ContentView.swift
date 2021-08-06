//
//  ContentView.swift
//  OnboardingScreen
//
//  Created by Sree Sai Raghava Dandu on 06/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       //Getting Screesize Globally
        GeometryReader{ proxy in
            let size = proxy.size
            HomeView(screenSize: size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
