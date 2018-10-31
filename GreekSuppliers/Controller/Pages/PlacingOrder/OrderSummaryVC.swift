//
//  OrderSummaryVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class OrderSummaryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var orderSummaryCollectionView: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!
    
    var categoryName: [String] = []
    var categoryDescription: [String] = []
    
    var refresher:UIRefreshControl!
    var currentPrice: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeNavBar()
        continueButton.layer.cornerRadius = 10
        
        refresher = UIRefreshControl()
        orderSummaryCollectionView.addSubview(refresher)
        refresher.beginRefreshing()
        loadData { (_) in
            self.refresher.endRefreshing()
        }
    }
    
    func loadData(completionHandler:@escaping (Bool)->() ){
        // Pulling info from firebase
        if let user = Auth.auth().currentUser{
            var ref = Database.database().reference().child("users").child(user.uid).child("ProductInfo")
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
                    ProductsPageVC.currentOrder.currentPrice = self.currentPrice * Float(ProductsPageVC.currentOrder.orderAmount)
                    self.finalPriceLabel.text = "Current Price: $" + String(ProductsPageVC.currentOrder.currentPrice)
                }
            }
            ref = Database.database().reference().child("users").child(user.uid).child("OrderInfo")
            ref.observeSingleEvent(of: .value) { (snapshot) in
                if let orderInfos = snapshot.value as? NSDictionary{
                    for (key, value) in orderInfos{
                        self.categoryName.append(key as! String)
                        self.categoryDescription.append(value as! String)
                    }
                    self.orderSummaryCollectionView.reloadData()
                    completionHandler(true)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCell
        
        cell.categoryLabel.text = categoryName[indexPath.row]
        cell.categoryDescription.text = categoryDescription[indexPath.row]
        return cell
        
    }
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
    
    @IBAction func dealsButtonPressed(_ sender: UIButton) {
//        let nextVC = storyBoard.instantiateViewController(withIdentifier: "DealsPageVC")
//        let navController = UINavigationController(rootViewController: nextVC)
//        self.presentDetail(navController)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismissDetail()
    }
}
