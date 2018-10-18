//
//  EmailPasswordVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class EmailPasswordVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var allSetButton: UIButton!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetButton.layer.cornerRadius = 10
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func allSetButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        guard let repeatPass = repeatPasswordTextField.text else {return}
        guard let username = userNameTextField.text else {return}
        
        guard (email != "") && (pass != "") && (repeatPass != "") && (username != "") else {
            alert(title: "One of the fields is empty", message: "You must fill out all of the fields")
            return
        }
        
        guard pass == repeatPass else {
            alert(title: "Typing error", message: "Password fields must be the same")
            return
        }
        
        guard pass.count >= 6 else {
            alert(title: "Password to short", message: "Password length must be at least 6 characters")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil{
                
                // clarify that this is the first time opening app, for mikes video thing
                
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    if error == nil{
                        self.performSegue(withIdentifier: "GoToHomePage", sender: self)
                    }
                })
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}
