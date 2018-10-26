//
//  NoPlanVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/14/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class NoPlanVC: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        customizeNavBar()
        customizeView()
    }
    
    func customizeView(){
        continueButton.layer.cornerRadius = 10
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
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
        if let user = Auth.auth().currentUser{
            Database.database().reference().child("users").child(user.uid).child("ProductInfo").removeValue()
                let nextVC = storyboard?.instantiateViewController(withIdentifier: "ProductsPageVC") as! ProductsPageVC
                let navController = UINavigationController(rootViewController: nextVC)
            presentDetail(navController)
        }
    }
    
}
