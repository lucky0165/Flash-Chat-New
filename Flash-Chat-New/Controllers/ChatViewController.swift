//
//  ChatViewController.swift
//  Flash-Chat-New
//
//  Created by Łukasz Rajczewski on 08/11/2020.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        messageTextField.delegate = self
        
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadData()
    }
    
    func saveData() {
        
        if let currentUser = Auth.auth().currentUser?.email, let bodyMessage = messageTextField.text {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: currentUser,
                K.FStore.bodyField: bodyMessage,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("Error adding document: \(e)")
                } else {
                    print("Document added")
                    self.messageTextField.text = ""
                }
            }
        }
    }
    
    func loadData() {
        
        db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
            
            self.messages = []
            
            if let e = error {
                print("Error loading documents: \(e)")
            } else {
                if let snapshotDoc = querySnapshot?.documents {
                    for doc in snapshotDoc {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            
                            DispatchQueue.main.async {
                                self.messages.append(newMessage)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        saveData()
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveData()
        return true
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.label.text = messages[indexPath.row].body
        
        return cell
    }
    
    
}
