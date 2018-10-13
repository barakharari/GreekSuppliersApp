//
//  AvailabilityPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit



class AvailabilityPageVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "dropoffLocation", sender: self)
    }
    
    @IBOutlet weak var pickUpLabel: UILabel!
    @IBOutlet weak var orderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        customizeNavBar()
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapView)
        
    }
    
    @objc func endEditing(_ sender: UIButton){
        view.endEditing(true)
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    private var datePicker: UIDatePicker?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderTime", for: indexPath) as! OrderTimeCell
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        cell.dayTextField.inputView = datePicker
        cell.datePicker = datePicker
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: cell, action: #selector(cell.updateTextField))
        accessoryView.items = [space, doneButton, space]
        
        
        cell.dayTextField.inputAccessoryView = accessoryView
        return cell
    }
}
