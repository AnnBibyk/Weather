//
//  ChatViewController.swift
//  d07
//
//  Created by Anna BIBYK on 1/24/19.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController, MessageInputBarDelegate {
    
    var messages: [Message] = []
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        let firstMessage = Message(user: "bot1", content: "Hi", color: .cyan)
        insertNewMessage(firstMessage)
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func insertNewMessage(_ message: Message) {
        messages.append(message)
        
        DispatchQueue.main.async { [weak self] in
            self?.messagesCollectionView.reloadData()
            self?.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let text = text.trimmingCharacters(in: .whitespaces)
        if text.isEmpty { return }
        
        let message = Message(user: "bot", content: inputBar.inputTextView.text, color: .green)
        insertNewMessage(message)
        
        if text != "" {
            networkManager.getLocation(inputBar.inputTextView.text, completion: { [weak self] (answer) in
                DispatchQueue.main.async {
                    let message = Message(user: "bot1", content: answer, color: .cyan)
                    self?.insertNewMessage(message)
                }
            })
        }
        inputBar.inputTextView.text = ""
    }
}

extension ChatViewController: MessagesDataSource {
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: "bot", displayName: "bot")
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }

}

extension ChatViewController: MessagesLayoutDelegate {
}

extension ChatViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .green : .lightGray
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .white
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}



