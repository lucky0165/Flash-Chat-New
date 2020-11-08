//
//  ViewController.swift
//  Flash-Chat-New
//
//  Created by Łukasz Rajczewski on 08/11/2020.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        registerButton.layer.cornerRadius = registerButton.frame.size.height / 2
    }


}

