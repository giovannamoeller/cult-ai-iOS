//
//  CustomTextField.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let isLoading: Bool
    let onSubmit: () -> Void
    
    @FocusState private var isFocused: Bool
    @State private var isHovering = false
    
    var body: some View {
        HStack(spacing: 12.0) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .font(.system(.body, design: .rounded))
                .textFieldStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(uiColor: .systemBackground))
                        .shadow(color: isFocused ? .indigo.opacity(0.3) : .gray.opacity(0.2),
                                radius: isFocused ? 8 : 4,
                                x: 0, y: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isFocused ? Color.indigo.opacity(0.5) : Color.gray.opacity(0.2), lineWidth: 1)
                )
                .disabled(isLoading)
            
            // Send Button
            Button(action: onSubmit) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(.white)
                        .frame(width: 24, height: 24)
                } else {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
            .frame(width: 44, height: 44)
            .background(
                Circle()
                    .fill(text.isEmpty || isLoading ? Color.indigo.opacity(0.5) : Color.indigo)
                    .shadow(color: .indigo.opacity(0.3),
                            radius: isHovering ? 8 : 4,
                            x: 0, y: 2)
            )
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isHovering = hovering
                }
            }
            .disabled(text.isEmpty || isLoading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomTextField(text: .constant("Hello!"), placeholder: "Type your text here", isLoading: false, onSubmit: {})
}
