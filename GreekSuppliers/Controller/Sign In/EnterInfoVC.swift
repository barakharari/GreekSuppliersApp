//
//  EnterInfoVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

protocol UserInfoProtocol{
    var name: String {get set}
    var number: String {get set}
    var school: String {get set}
}

class EnterInfoVC: UIViewController, UserInfoProtocol, UITextFieldDelegate {
    
    var name: String = ""
    var number: String = ""
    var school: String = ""

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 10
        
        nameTextField.delegate = self
        numberTextField.delegate = self
        schoolTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(endTheEditing))
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc func endTheEditing(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        
        guard let aName = nameTextField.text else {return}
        guard let aNumber = numberTextField.text else {return}
        guard let aSchool = schoolTextField.text else {return}
        
        guard (aName != "") && (aNumber != "") && (aSchool != "") else {
            alert(title: "One of the fields is empty", message: "You must fill out all of the fields")
            return
        }
        
        name = aName
        number = aNumber
        school = aSchool
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "EmailPassword") as! EmailPasswordVC
        present(nextVC, animated: true, completion: nil)
        nextVC.userInfoDelegate = self
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
