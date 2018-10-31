//
//  DealsPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class DealsPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    var categoryName: [String] = []
    var categoryDescription: [String] = []
    var currentPrice: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.layer.cornerRadius = 10
        customizeNavBar()
        
        loadData()
        
    }
    
    func loadData(){
        // Pulling info from firebase
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("users").child(user.uid).child("ProductInfo")
            ref.observe(.value) { (snapshot) in
                if let products = snapshot.value as? [String: AnyObject]{
                    for (name, details) in products{
                        self.categoryName.append(name)
                        if let details = details as? [String: String]{
                            self.categoryDescription.append(details["Offer"]!)
                            
                            if let price = Float(details["Price"]!){
                                self.currentPrice += price
                            } else{
                                print("Something went wrong with pricing")
                            }
                        }
                    }
                    self.currentPriceLabel.text = "Current Price: $" + String(self.currentPrice)
                }
            }
        }
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealCell", for: indexPath) as! DealCell
        return cell
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismissDetail()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("/users").child(user.uid).child("/OrderInfo")
            ref.setValue(["Final Price": self.currentPrice])
        }
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "AvailabilityVC")
        let navController = UINavigationController(rootViewController: nextVC)
        self.presentDetail(navController)
    }
}
