//
//  ViewController.swift
//  Messenger
//
//  Created by Art Karma on 5/6/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ViewController: MessagesViewController {
    
    var messages: [Message] = []
    var member: Member!
    var chatService: ChatService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        member = Member(name: .randomName, color: .random)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        chatService = ChatService(member: member, onRecievedMessage: {
            [weak self] message in
            self?.messages.append(message)
            self?.messagesCollectionView.reloadData()
            self?.messagesCollectionView.scrollToBottom(animated: true)
        })
        
        chatService.connect()
    }
    
    
}

extension ViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(senderId: member.name, displayName: member.name)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 12
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(string: message.sender.displayName, attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
    
    
}

extension ViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
}

extension ViewController: MessagesDisplayDelegate {
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let message = messages[indexPath.section]
        let color = message.member.color
        avatarView.backgroundColor = color
    }
}

extension ViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//        let newMessage = Message(member: member, text: text, id: UUID().uuidString)
//        messages.append(newMessage)
//        inputBar.inputTextView.text = ""
//        messagesCollectionView.reloadData()
//        messagesCollectionView.scrollToBottom(animated: true)
        chatService.sendMessage(text)
        inputBar.inputTextView.text = ""
    }
}
