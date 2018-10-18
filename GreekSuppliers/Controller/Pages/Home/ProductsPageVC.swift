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
    
    static var currentProduct: Product!
    
    var products = [Product]()
    
    //refreshing function add to this?
    @objc func refresh(){
        //productCollectionView.reloadData()
        refresher.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up Nav Bar
        customizeNavBar()
        
        // Customize Button
        continueButton.layer.cornerRadius = 10
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        productCollectionView.addSubview(refresher)
        
        self.loadData()

    }
    
    func loadData(){
        // Create a reference to database
        dbRef = Database.database().reference()
        
        // Parse each post
        dbRef.child("Products").observeSingleEvent(of: .value) { (snapshot) in
            
            let products = snapshot.value as! [String: AnyObject]
        
            for product in products{
                let newProduct = Product(name: product.key, snapshot: snapshot)
                self.products.append(newProduct)
            }
            self.productCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        //Styling
        cell.productImageView.layer.cornerRadius = 8
        cell.productImageView.layer.borderWidth = 0.5
        cell.productImageView.layer.borderColor = UIColor.lightGray.cgColor
        cell.productName.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.productImageView.sd_setImage(with: URL(string: self.products[indexPath.row].imageDownloadURL)) { (image, error, cache, url) in
            cell.productName.text = self.products[indexPath.row].name
            
            if image != nil{
                self.products[indexPath.row].image = image
            }
            
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductInfo") as! ProductInfoVC
        ProductsPageVC.currentProduct = products[indexPath.row]
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
        dismiss(animated: true, completion: nil)
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }

}
