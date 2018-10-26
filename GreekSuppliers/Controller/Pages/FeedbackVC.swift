//
//  FeedbackVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/25/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class FeedbackVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var feedbackButton: UIButton!
    
    private var placeHolderText = "Enter your feedback here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackTextView.delegate = self
        
        sideMenu()
        customizeNavBar()
        customizeView()
        
    }
    
    func customizeView(){
        feedbackTextView.layer.borderWidth = 0.5
        feedbackButton.layer.cornerRadius = 10
        feedbackTextView.text = placeHolderText
        feedbackTextView.textColor = UIColor.lightGray
    }
    
    func sideMenu(){
        if revealViewController() != nil{
            menuBarButton.target = revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 275
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func feedbackButtonPressed(_ sender: UIButton) {
        guard feedbackTextView.text != nil || feedbackTextView.text != placeHolderText else {
            alert(title: "Feedback Empty", message: "Must include a message with your feedback")
            return
        }
        alert(title: "Message Recieved", message: "Thanks for reaching out! Feel free to tell us more.")
        feedbackTextView.text = ""
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
