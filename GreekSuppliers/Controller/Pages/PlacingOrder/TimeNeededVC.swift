//
//  TimeNeededVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class TimeNeededVC: UIViewController {
    
    @IBOutlet weak var timeInputField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        
        continueButton.layer.cornerRadius = 10
        timeInputField.keyboardType = .numberPad
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(doneTyping))
        view.addGestureRecognizer(tapScreen)
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneTyping))
        accessoryView.items = [space, doneButton, space]
        timeInputField.inputAccessoryView = accessoryView
    }
    
    @objc func doneTyping(){
        view.endEditing(true)
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
        guard let orderAmount = timeInputField.text else {
            alert(title: "Input an Order Amount", message: "Must give a number of orders before continuing")
            return
            
        }
        guard Int(orderAmount) != nil else {
            alert(title: "Invalid Entry", message: "Must input a number")
            return
        }
        guard Int(orderAmount)! < 10 else {
            alert(title: "Too many orders", message: "Contact us personally for a 10+ order")
            return
        }
        guard Int(orderAmount)! > 0 else {
            alert(title: "Invalid Entry", message: "Must input a positive number between 0 and 10")
            return
        }
        
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("/users").child(user.uid).child("/OrderInfo")
            let value = ["Order Amount": orderAmount]
            ref.setValue(value)
            ProductsPageVC.currentOrder.orderAmount = Int(orderAmount)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "OrderSummaryVC")
            let navController = UINavigationController(rootViewController: nextVC)
            self.presentDetail(navController)
        }
    }
}
