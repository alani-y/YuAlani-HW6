//
//  LoginVC.swift
//  YuAlani-HW5
//
//  Created by Alani Yu on 3/15/25.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController{
    
    @IBOutlet weak var signInController: UISegmentedControl!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userIDField: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    let segueIdentifier = "LoginSegue"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
        
        Auth.auth().addStateDidChangeListener(){
            (_, user) in
            if user != nil {
                self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
                self.userIDField.text = nil
                self.passwordField.text = nil
            }
        }
    }
    
    // signs the user in when clicked
    @IBAction func signInButton(_ sender: Any) {
        
        let userID = userIDField.text!
        let password = passwordField.text!
        
        switch signInController.selectedSegmentIndex{
        case 1:
            // checks if the password and confirm password field match
            if password != confirmPasswordField.text {
                errorMessage.isHidden = false
                errorMessage.text = "Your passwords do not match."
            }
            else{
                // creates a new user
                Auth.auth().createUser(withEmail: userID, password: password) {
                    (authResult, error) in
                    if let error = error as NSError? {
                        self.errorMessage.isHidden = false
                        self.errorMessage.text = "\(error.localizedDescription)"
                    }
                    else {
                        self.errorMessage.isHidden = true
                    }
                }
            }
            
        default:
            // changes to the login UI
            self.errorMessage.isHidden = false
            signInButton.setTitle("Sign In", for: .normal)
            Auth.auth().signIn(withEmail: userID, password: password){
                (authResult, error) in
                if let error = error as NSError? {
                    self.errorMessage.text = "\(error.localizedDescription)"
                }
                else {
                    self.errorMessage.isHidden = true
                }
            }
        }
    }
    
    // changes the UI to reflect if the user is signing in or
    // signing up
    @IBAction func onSignUpController(_ sender: Any){
        switch signInController.selectedSegmentIndex {
        case 1:
            confirmPasswordField.isHidden = false
            confirmPasswordLabel.isHidden = false
            signInButton.setTitle("Sign Up", for: .normal)
            
        default:
            confirmPasswordField.isHidden = true
            confirmPasswordLabel.isHidden = true
            signInButton.setTitle("Sign In", for: .normal)
        }
    }
}
