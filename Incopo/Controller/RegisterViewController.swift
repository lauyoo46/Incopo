//
//  RegisterViewController.swift
//  Incopo
//
//  Created by Laurentiu Ile on 09.02.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let decimalCharacters = CharacterSet.decimalDigits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedOutside()
    }
    
    @IBAction func singUpPressed(_ sender: Any) {
        
        let user = User(email: emailTextField.text ?? "",
                        firstName: firstNameTextField.text ?? "",
                        lastName: lastNameTextField.text ?? "",
                        password: passwordTextField.text ?? "",
                        recents: [],
                        profilePicture: UIImage())
        
        let error = validateUser(user: user)
        if let error = error {
            ICPAlert.showAlert(on: self, with: "Registration failed".localized, message: error)
            return
        }
        
        performRegistration(user: user)
    }
    
    func validateUser(user: User) -> String? {
        var error: String?
        
        let firstNameContainsDecimals = user.firstName.rangeOfCharacter(from: decimalCharacters)
        if firstNameContainsDecimals != nil {
            error = "First Name must not contain decimals".localized
            return error
        }
        
        let lastNameContainsDecimals = user.lastName.rangeOfCharacter(from: decimalCharacters)
        if lastNameContainsDecimals != nil {
            error = "Last Name must not contain decimals".localized
            return error
        }
        
        guard let confirmedPassword = confirmPasswordTextField.text else {
            error = "Confirmation field must not be empty".localized
            return error
        }
        if user.password != confirmedPassword {
            error = "Passwords does not match".localized
            return error
        }
        
        return error
    }
    
    func performRegistration(user: User) {
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (_, error) in
            
            if let registrationError = error {
                ICPAlert.showAlert(on: self, with: "Registration Error".localized, message: registrationError.localizedDescription)
            } else {
                
                FirestoreManager.shared.collection(Constants.userCollection).document(user.email).setData([
                    Constants.email: user.email,
                    Constants.firstName: user.firstName,
                    Constants.lastName: user.lastName,
                    Constants.recents: []
                ])
                
                self.clearFields()
                
                ICPAlert.showAlert(on: self, with: "Registration Message".localized, message: "You registered successfully".localized)
            }
        }
    }
    
    func clearFields() {
        
        emailTextField.text = ""
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}
