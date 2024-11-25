//
//  3DWebViewer.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import SwiftUI
import WebKit

struct _DWebViewer: View {
    let modelUrl: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            WebView(url: modelUrl)
                .navigationTitle("Visualizador de obras 3D")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Fechar") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    _DWebViewer(modelUrl: "https://lumalabs.ai/embed/18947f38-0421-47fa-bb20-51c658a144b7?mode=sparkles&background=%23ffffff&color=%23000000&cinematicVideo=undefined&showMenu=false")
}
