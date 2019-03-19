//
//  Message.swift
//  d07
//
//  Created by Anna BIBYK on 1/24/19.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    
    let id: String?
    let content: String
    let sentDate: Date
    let sender: Sender
    var messageId: String
    var kind: MessageKind
    var color: UIColor
    
    init(user: String, content: String, color: UIColor) {
        self.sender = Sender(id: user, displayName: "bot")
        self.content = content
        self.sentDate = Date()
        self.id = nil
        self.messageId = content
        self.kind = .text(content)
        self.color = color
    }
}

extension Message: Comparable {
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}

