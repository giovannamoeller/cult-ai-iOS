//
//  OnboardingStep.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import Foundation

struct OnboardingStep: Identifiable, Equatable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}
