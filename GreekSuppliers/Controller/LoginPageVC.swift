//
//  LoginPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/15/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class LoginPageVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "signupSegue", sender: self)
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil{
                self.performSegue(withIdentifier: "GoToHome", sender: self)
            } else {
                self.alert(title: "Incorrect Credentials", message: "Seems your email or password might be incorrect, try again")
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser{
            performSegue(withIdentifier: "GoToHome", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
    }

}
