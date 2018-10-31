//
//  AvailabilityPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit



class AvailabilityPageVC: UIViewController{

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var dateEntry: UITextField!
    
    private var datePicker: UIDatePicker?
    
    @objc func endEditing(_ sender: UIButton){
        view.endEditing(true)
    }
    
    func customizeView(){
        continueButton.layer.cornerRadius = 10
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
    
    @objc func updateTextField(){
        if let datePicker = datePicker{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateEntry.text = dateFormatter.string(from: datePicker.date)
            dateFormatter.dateFormat = "hh:mm a"
            dateEntry.text = dateEntry.text! + " at " + dateFormatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
    }
    
    func setUpDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        dateEntry.inputView = datePicker
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(updateTextField))
        accessoryView.items = [space, doneButton, space]
        dateEntry.inputAccessoryView = accessoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        customizeView()
        setUpDatePicker()

        let tapView = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapView)
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismissDetail()
    }
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "SetDropOff")
        let navController = UINavigationController(rootViewController: nextVC)
        self.presentDetail(navController)
    }
}
