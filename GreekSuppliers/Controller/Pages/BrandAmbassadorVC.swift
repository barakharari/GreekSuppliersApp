//
//  BrandAmbassadorVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/11/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class BrandAmbassadorVC: UIViewController{

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var brandAmbassadorButton: UIButton!
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func brandAmbassadorButtonPressed(_ sender: UIButton) {
        brandAmbassadorButton.setTitle("Interest shown", for: .normal)
        brandAmbassadorButton.backgroundColor = UIColor.lightGray
        brandAmbassadorButton.isEnabled = false
        alert(title: "Thanks for the interest!", message: "You will reviece a text/call sometime in the next 3-5 business days.")
        
        // TODO: Press again if pressed by accident/ wanna revoke interest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        customizeNavBar()
        customizeView()
    }
    
    func customizeView(){
        brandAmbassadorButton.layer.cornerRadius = 10
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
