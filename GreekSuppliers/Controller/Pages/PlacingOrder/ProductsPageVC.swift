//
//  ProductsPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class ProductsPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var dbRef: DatabaseReference!
    var storageRef: StorageReference!
    
    var refresher:UIRefreshControl!
    
    static var currentOrder: Order = Order()
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up Nav Bar
        customizeNavBar()
        
        // Customize Button
        continueButton.layer.cornerRadius = 10
        
        refresher = UIRefreshControl()
        productCollectionView.addSubview(refresher)
        
        self.refresher.beginRefreshing()
        self.loadData{_ in
            self.refresher.endRefreshing()
        }
    }
    
    func loadData(completionHandler:@escaping (Bool)->() ){
        // Remove items from array
        self.products.removeAll()
        // Create a reference to database
        dbRef = Database.database().reference().child("Products")
        
        // Parse each post
        dbRef.observeSingleEvent(of: .value) { (snapshot) in
            
            let products = snapshot.value as! [String: AnyObject]
        
            for product in products{
                let newProduct = Product(name: product.key, snapshot: snapshot)
                self.products.append(newProduct)
            }
            self.productCollectionView.reloadData()
            completionHandler(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        //Styling
        cell.clearButton.layer.borderColor = view.backgroundColor?.cgColor
        
        cell.productImageView.sd_setImage(with: URL(string: self.products[indexPath.row].imageDownloadURL)) { (image, error, cache, url) in
            cell.productName.text = self.products[indexPath.row].name
            
            if image != nil{
                self.products[indexPath.row].image = image
            }
            
        }
        
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("users").child(user.uid).child("ProductInfo").child(self.products[indexPath.row].name)
            ref.observe(.value) { (snapshot) in
                if snapshot.exists(){
                    cell.clearButton.isHidden = false
                    cell.productAmount.isHidden = false
                    
                    // Extracting the value for the offer amount
                    if let offer = snapshot.value as? [String: AnyObject]{
                        // Iterating through this string, and adding all numeric values to a new one to present to the view
                        var characterString = "x"
                        
                        for letter in (offer["Offer"] as! String).unicodeScalars{
                            if CharacterSet.decimalDigits.contains(letter){
                                characterString.unicodeScalars.append(letter)
                            }
                        }
                        cell.productAmount.text = String(characterString)
                    }
                } else{
                    cell.clearButton.isHidden = true
                    cell.productAmount.isHidden = true
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductInfo") as! ProductInfoVC
        
        ProductsPageVC.currentOrder.product = products[indexPath.row]
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 10, height: (view.frame.width / 2) + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
        if let user = Auth.auth().currentUser{
        Database.database().reference().child("users").child(user.uid).child("ProductInfo").removeValue()
            self.dismissDetail()
        }
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
        print("BUTTON PRESSED")
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("users").child(user.uid).child("ProductInfo")
            ref.observe(.value) { (snapshot) in
                if snapshot.exists(){
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: "TimeNeededVC") as! TimeNeededVC
                    let navController = UINavigationController(rootViewController: nextVC)
                    self.presentDetail(navController)
                } else{
                    self.alert(title: "Choose products", message: "Must choose products to continue!")
                }
            }
        }
        
        
    }
    

}
