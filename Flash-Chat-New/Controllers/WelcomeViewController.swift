//
//  ViewController.swift
//  Flash-Chat-New
//
//  Created by Łukasz Rajczewski on 08/11/2020.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let appName = K.appName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        registerButton.layer.cornerRadius = registerButton.frame.size.height / 2
        
        titleLabel.text = ""
        titleFlash()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.titleBlink()
        }
    }
    
    func titleBlink() {
        
        var index = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            
            if index == 6 {
                timer.invalidate()
            } else if index % 2 == 0 {
                self.titleLabel.alpha = 0
            } else {
                self.titleLabel.alpha = 1
            }
            index += 1
        }
    }
    
    func titleFlash() {
        
        var charIndex:Double = 0
        
        for letter in appName {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
}

