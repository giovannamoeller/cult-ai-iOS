//
//  ChatViewModel.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI
import Combine

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(type: .ai, content: "Olá, em que posso ajudá-lo?")
    ]
    @Published var inputMessage = ""
    @Published var isLoading = false
    @Published var show3DModel = false
    @Published var modelUrl: String?
    
    func sendMessage() async {
        guard !inputMessage.isEmpty else { return }
        
        withAnimation {
            let userMessage = Message(type: .human, content: inputMessage)
            messages.append(userMessage)
            
            let loadingMessage = Message(type: .ai, content: "", isMarkdown: true, isLoading: true)
            messages.append(loadingMessage)
            
            modelUrl = nil
            show3DModel = false
            
            let _ = inputMessage
            inputMessage = ""
            isLoading = true
        }
        
        do {
            let url = URL(string: "https://culture-ai-api.fly.dev/chat")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let messageData = messages
                .filter { !$0.isLoading } // Filter out loading messages
                .map { ["type": $0.type.rawValue, "content": $0.content] }
            let jsonData = try JSONSerialization.data(withJSONObject: messageData)
            request.httpBody = jsonData
            
            let (stream, response) = try await URLSession.shared.bytes(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            var accumulatedContent = ""
            
            for try await line in stream.lines {
                guard line.hasPrefix("data: ") else { continue }
                
                let data = line.dropFirst(6)
                guard let messageData = data.data(using: .utf8),
                      let json = try? JSONSerialization.jsonObject(with: messageData) as? [String: String],
                      let type = json["type"],
                      let content = json["content"] else {
                    continue
                }
                
                if type == "url" {
                    modelUrl = content
                    //show3DModel = true
                } else {
                    accumulatedContent += content
                    // Update the loading message with accumulated content
                    messages[messages.count - 1] = Message(
                        type: .ai,
                        content: accumulatedContent,
                        isMarkdown: true,
                        isLoading: false
                    )
                }
            }
        } catch {
            messages.removeLast() // Remove loading message
            messages.append(Message(type: .ai, content: "Sorry, there was an error processing your request."))
        }
        
        isLoading = false
    }
    
}
