//
//  AuthController.swift
//  O-B-Dometer
//
//  Created by Connor Critchley on 4/1/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class AuthController: UIViewController {
    
    @IBOutlet var emailField:UITextField!
    @IBOutlet var passField:UITextField!
    @IBOutlet var invalidLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text ?? "", password: passField.text ?? "") { authResult, error in
            if let error = error {
                // An error occurred while creating the user account
                print("Error logging in: \(error.localizedDescription)")
                self.invalidLabel.isHidden = false
            } else {
                // The user sucessfully logged in.
                AppDelegate.shared().uid = "\(authResult?.user.uid ?? "")"
                print("User logged in: \(authResult?.user.uid ?? "")")
                self.performSegue(withIdentifier: "go", sender: self)
            }
        }
        
    }
    
    @IBAction func createAcc(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailField.text ?? "", password: passField.text ?? "") { authResult, error in
            if let error = error {
                // An error occurred while creating the user account
                print("Error creating user: \(error.localizedDescription)")
            } else {
                // The user account was successfully created
                AppDelegate.shared().uid = "\(authResult?.user.uid ?? "")"
                print("User created: \(authResult?.user.uid ?? "")")
                self.performSegue(withIdentifier: "go", sender: self)
            }
        }
        
    }
    /*
     // MARK: - Navigation
    */
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
}
