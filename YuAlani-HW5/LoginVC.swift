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
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    @IBOutlet weak var ConfirmPasswordLabel: UILabel!
    
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var UserIDField: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var SignInButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener(){
            (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                self.UserIDField.text = nil
                self.PasswordField.text = nil
            }
        }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
    }
    
    // creates a new user
    @IBAction func onSignUpController(_ sender: Any){
        switch signInController.selectedSegmentIndex {
        case 1:
            ConfirmPasswordField.isHidden = false
            ConfirmPasswordLabel.isHidden = false
            SignInButton.setTitle("Sign Up", for: .normal)
            
            let userID = UserIDField.text!
            let password = PasswordField.text!
            
            if password != ConfirmPasswordField.text {
                errorMessage.text = "Your passwords do not match."
            }
            else{
                Auth.auth().createUser(withEmail: userID, password: password) {
                    (authResult, error) in
                    if let error = error as NSError? {
                        self.errorMessage.text = "\(error.localizedDescription)"
                    }
                    else{
                        self.errorMessage.text = ""
                    }
                }
            }
            
        default:
            ConfirmPasswordField.isHidden = true
            ConfirmPasswordLabel.isHidden = true
            SignInButton.setTitle("Sign In", for: .normal)
        }
    }
}
