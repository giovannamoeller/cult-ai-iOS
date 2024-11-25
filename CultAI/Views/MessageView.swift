//
//  MessageView.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI
import MarkdownUI

struct MessageView: View {
    let message: Message
    let isLatest: Bool
    
    var body: some View {
        HStack {
            if message.type == .human {
                Spacer()
            }
            VStack {
                if message.isLoading {
                    LoadingIndicator()
                        .transition(.scale.combined(with: .opacity))
                } else {
                    Markdown(message.content)
                        .padding()
                        .markdownTextStyle(textStyle: {
                            ForegroundColor(message.type == .human ? .white : .primary)
                        })
                        .background(message.type == .human ? Color.indigo : Color.gray.opacity(0.2))
                        .cornerRadius(16)
                        .textSelection(.enabled)
                }
            }
            .scaleEffect(isLatest ? 1 : 0.98)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isLatest)
            // Message appear animation
            .transition(message.type == .human
                        ? .asymmetric(
                            insertion: .scale(scale: 0.8)
                                .combined(with: .opacity)
                                .combined(with: .slide)
                                .animation(.spring(response: 0.4, dampingFraction: 0.7)),
                            removal: .opacity.animation(.easeOut(duration: 0.2)))
                        : .asymmetric(
                            insertion: .scale(scale: 0.8)
                                .combined(with: .opacity)
                                .animation(.spring(response: 0.4, dampingFraction: 0.7)),
                            removal: .opacity.animation(.easeOut(duration: 0.2)))
            )
            if message.type == .ai {
                Spacer()
            }
        }
    }
}

#Preview {
    MessageView(message: ChatViewModel().messages.first!, isLatest: true)
}
