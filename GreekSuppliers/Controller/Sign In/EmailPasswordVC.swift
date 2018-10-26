//
//  EmailPasswordVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class EmailPasswordVC: UIViewController, UITextFieldDelegate{
    

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var allSetButton: UIButton!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    var userInfoDelegate: UserInfoProtocol!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetButton.layer.cornerRadius = 10
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(endTheEditing))
        view.addGestureRecognizer(tapScreen)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func endTheEditing(){
        self.view.endEditing(true)
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
            if error == nil{
                if let validUser = user{
                    let ref = Database.database().reference().child("users").child(validUser.user.uid)
                    let values = ["name": self.userInfoDelegate.name, "number": self.userInfoDelegate.number, "school": self.userInfoDelegate.school]
                    ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
                        if err != nil{
                            print(err?.localizedDescription)
                            return
                        } else{
                            self.performSegue(withIdentifier: "GoToHomePage", sender: self)
                        }
                    })
                }
                
                // clarify that this is the first time opening app, for mikes video thing
    

            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    // Adjusting keyboard
    @objc func keyboardWillChange(notification: Notification){
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification{
            view.frame.origin.y = -keyboardRect.height
        } else{
            view.frame.origin.y = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        print("DEINITIALIZED")
    }
}
