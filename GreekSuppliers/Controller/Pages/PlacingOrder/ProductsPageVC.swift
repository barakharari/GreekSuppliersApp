//
//  ProductsPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class ProductsPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var dbRef: DatabaseReference!
    var storageRef: StorageReference!
    
    var refresher:UIRefreshControl!
    
    static var currentOrder: Order = Order()
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up Nav Bar
        customizeNavBar()
        customizeView()
    }
    
    func customizeView(){
        // Customize Button
        continueButton.layer.cornerRadius = 10
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (productCollectionView.frame.width / 2) - 20, height: (productCollectionView.frame.width / 2) + 30)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        productCollectionView.collectionViewLayout = layout
        
        refresher = UIRefreshControl()
        productCollectionView.addSubview(refresher)
        productCollectionView.layer.borderWidth = 1.0
        productCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        
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
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("users").child(user.uid).child("ProductInfo")
            ref.observe(.value) { (snapshot) in
                if snapshot.exists(){
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: "DealsPageVC") as! DealsPageVC
                    let navController = UINavigationController(rootViewController: nextVC)
                    self.presentDetail(navController)
                } else{
                    self.alert(title: "Choose products", message: "Must choose a product to continue!")
                }
            }
        }
        
        
    }
    

}
