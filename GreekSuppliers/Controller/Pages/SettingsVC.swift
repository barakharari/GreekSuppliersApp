//
//  SettingsVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/11/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UIViewController{

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        customizeNavBar()
        customizeView()
    }
    
    func customizeView(){
        logOutButton.layer.cornerRadius = 10
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

}
