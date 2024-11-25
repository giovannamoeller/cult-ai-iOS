//
//  OnboardingView.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var pageOffset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                TabView(selection: $viewModel.currentStep) {
                    ForEach(Array(viewModel.steps.enumerated()), id: \.element.id) { index, step in
                        VStack(spacing: 34.0) {
                            Image(step.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 132, height: 132)
                                .foregroundColor(.indigo)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(Color.indigo.opacity(0.1))
                                        .frame(width: 204, height: 204)
                                )
                                .scaleEffect(index == viewModel.currentStep ? 1 : 0.8)
                                .animation(.spring(), value: viewModel.currentStep)
                            
                            Text(step.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top)
                            
                            Text(step.description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 32)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.default, value: viewModel.currentStep)
                
                // Progress Indicators
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.steps.count, id: \.self) { index in
                        Circle()
                            .fill(index == viewModel.currentStep ? Color.indigo : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .scaleEffect(index == viewModel.currentStep ? 1.2 : 1.0)
                            .animation(.spring(), value: viewModel.currentStep)
                    }
                }
                .padding(.top, 20)
                
                // Navigation Buttons
                HStack(spacing: 20) {
                    if !viewModel.isLastStep {
                        Button(action: {
                            hasCompletedOnboarding = true
                        }) {
                            Text("Pular")
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    Button(action: {
                        if viewModel.isLastStep {
                            hasCompletedOnboarding = true
                        } else {
                            viewModel.nextStep()
                        }
                    }) {
                        HStack {
                            Text(viewModel.isLastStep ? "Vamos começar!" : "Próximo")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(Color.indigo)
                        .clipShape(Capsule())
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
    }
}

#Preview {
    OnboardingView()
}
