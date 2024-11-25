//
//  Message.swift
//  CultAI
//
//  Created by Giovanna Moeller on 24/11/24.
//

import Foundation

enum MessageType: String, Codable {
    case ai
    case human
}

struct Message: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let type: MessageType
    let content: String
    var isMarkdown: Bool = false
    var isLoading: Bool = false
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id &&
        lhs.type == rhs.type &&
        lhs.content == rhs.content &&
        lhs.isMarkdown == rhs.isMarkdown &&
        lhs.isLoading == rhs.isLoading
    }
}
