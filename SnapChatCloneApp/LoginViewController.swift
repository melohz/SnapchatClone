//
//  LoginViewController.swift
//  SnapChatCloneApp
//
//  Created by 板垣智也 on 2019/04/14.
//  Copyright © 2019 板垣智也. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func topButtonTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if signupMode {
                // Sign Up
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        self.presentAlert(alert: error.localizedDescription)
                    } else {
                        print("Sign Up was successful")
                    }
                }
            } else {
                // Log In
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        self.presentAlert(alert: error.localizedDescription)
                    } else {
                        print("Log In was successful")
                    }
                }
            }
        }
    }
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func bottomButtonTapped(_ sender: Any) {
        if signupMode {
            // Switch to log in
            signupMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
        } else {
            // Switch to sign up
            signupMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
        }
    }
    
}

