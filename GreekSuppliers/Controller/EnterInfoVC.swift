//
//  EnterInfoVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class EnterInfoVC: UIViewController {

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
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        
        guard let name = nameTextField.text else {return}
        guard let number = numberTextField.text else {return}
        guard let school = schoolTextField.text else {return}
        
        guard (name != "") && (number != "") && (school != "") else {
            alert(title: "One of the fields is empty", message: "You must fill out all of the fields")
            return
        }
        
        let ref = Database.database().reference()
        ref.child("user").childByAutoId().setValue(["name": name, "number": number, "school": school])
        
        performSegue(withIdentifier: "EmailPassword", sender: self)
    }
}
