//
//  LoginVC.swift
//  YuAlani-HW5
//
//  Created by Alani Yu on 3/15/25.
//

import UIKit

class LoginVC: UIViewController{
    
    @IBOutlet weak var signInController: UISegmentedControl!
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    @IBOutlet weak var ConfirmPasswordLabel: UILabel!
    
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var UserIDField: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
    }
    
    @IBAction func onSignUpController(_ sender: Any){
        switch signInController.selectedSegmentIndex {
        case 1:
            ConfirmPasswordField.isHidden = false
            ConfirmPasswordLabel.isHidden = false
            
            
        default:
            ConfirmPasswordField.isHidden = true
            ConfirmPasswordLabel.isHidden = true
        }
    }
}
