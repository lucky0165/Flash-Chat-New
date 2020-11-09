//
//  Constants.swift
//  Flash-Chat-New
//
//  Created by Łukasz Rajczewski on 09/11/2020.
//

import Foundation

struct K {
    static let appName = "FlashChat "
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let nibName = "MessageCell"
    static let cellIdentifier = "ReusableCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
