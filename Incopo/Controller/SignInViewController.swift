//
//  ViewController.swift
//  Incopo
//
//  Created by Laurentiu Ile on 08.02.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedOutside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearFields()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
                
                if let error = error {
                    ICPAlert.showAlert(on: self, with: "Login Error".localized, message: error.localizedDescription)
                } else {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                        return
                    }
                    
                    let tabBarController = Storyboard.Main.tabBar.viewController
                    sceneDelegate.window?.rootViewController = tabBarController
                }
            }
        }
        
    }
    
    func clearFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
