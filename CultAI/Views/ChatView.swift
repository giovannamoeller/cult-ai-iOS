//
//  ChatView.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var scrollProxy: ScrollViewProxy?
    @Namespace private var bottomID
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12.0) {
                            ForEach(Array(viewModel.messages.enumerated()), id: \.element.id) { index, message in
                                MessageView(message: message, isLatest: index == viewModel.messages.count - 1)
                                    .id(message.id)
                            }
                            Color.clear
                                .frame(height: 1)
                                .id(bottomID)
                        }
                        .padding()
                    }
                    .onAppear {
                        scrollProxy = proxy
                    }
                    .onChange(of: viewModel.messages) { _, _ in
                        if let lastId = viewModel.messages.last?.id {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                scrollProxy?.scrollTo(lastId, anchor: .bottom)
                            }
                        }
                    }
                }
                
                VStack {
                    if viewModel.modelUrl != nil && !viewModel.isLoading {
                        Button {
                            viewModel.show3DModel = true
                        } label: {
                            HStack {
                                Image(systemName: "cube.transparent")
                                Text("Visualizar modelo 3D")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
                    CustomTextField(text: $viewModel.inputMessage, placeholder: "Digite sua mensagem...", isLoading: viewModel.isLoading) {
                        Task {
                            await viewModel.sendMessage()
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Firefingers Bot Cultural")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $viewModel.show3DModel) {
                if let modelUrl = viewModel.modelUrl {
                    _DWebViewer(modelUrl: modelUrl)
                }
            }
        }
    }
}

#Preview {
    ChatView()
}
