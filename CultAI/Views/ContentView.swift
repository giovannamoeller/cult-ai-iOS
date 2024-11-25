//
//  ContentView.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        if hasCompletedOnboarding {
            ChatView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
