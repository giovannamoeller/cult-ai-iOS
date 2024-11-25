//
//  OnboardingViewModel.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var isOnboardingComplete: Bool = false
    @Published var currentStep: Int = 0
    
    let steps: [OnboardingStep] = [
        OnboardingStep(
            image: "old-vase",
            title: "Chat Cultural com IA",
            description: "Explore arte e cultura através de conversas interativas com nosso assistente de IA."
        ),
        OnboardingStep(
            image: "sculpting",
            title: "Visualização de Arte em 3D",
            description: "Visualize modelos 3D impressionantes de obras de arte diretamente no aplicativo para uma experiência imersiva."
        ),
        OnboardingStep(
            image: "chat",
            title: "Respostas em Tempo Real",
            description: "Obtenha respostas instantâneas e informativas sobre arte, história e patrimônio cultural."
        ),
        OnboardingStep(
            image: "ready-to-explore",
            title: "Pronto para Explorar?",
            description: "Comece sua jornada pela arte e cultura com nosso assistente de IA."
        )
    ]
    
    var isLastStep: Bool {
        currentStep == steps.count - 1
    }
    
    func nextStep() {
        if currentStep < steps.count - 1 {
            currentStep += 1
        }
    }
    
    func previousStep() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }
}

