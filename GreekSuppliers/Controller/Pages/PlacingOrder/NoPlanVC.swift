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
    @IBOutlet weak var chooseExistingButton: UIButton!
    @IBOutlet weak var createNewButton: UIButton!
    
    @IBAction func chooseExistingPressed(_ sender: UIButton) {
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ExistingOrderVC") as! ExistingOrdersVC
        let navController = UINavigationController(rootViewController: nextVC)
        self.presentDetail(navController)
    }
    
    @IBAction func createNewPressed(_ sender: UIButton) {
        if let user = Auth.auth().currentUser{
            Database.database().reference().child("users").child(user.uid).child("ProductInfo").removeValue()
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "ProductsPageVC") as! ProductsPageVC
            let navController = UINavigationController(rootViewController: nextVC)
            presentDetail(navController)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        customizeNavBar()
        customizeView()
    }
    
    func customizeView(){
        chooseExistingButton.layer.cornerRadius = 10
        chooseExistingButton.layer.borderWidth = 1.2
        chooseExistingButton.layer.borderColor = UIColor(red: 126/255, green: 25/255, blue: 27/255, alpha: 1.0).cgColor
        createNewButton.layer.cornerRadius = 10
        createNewButton.layer.borderWidth = 1.2
        createNewButton.layer.borderColor = UIColor(red: 126/255, green: 25/255, blue: 27/255, alpha: 1.0).cgColor
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
