//
//  DealsPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class DealsPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.layer.cornerRadius = 10
        currentPriceLabel.text = "Current Price: " + String(ProductsPageVC.currentOrder.currentPrice)
        customizeNavBar()
        
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
        cell.dealConfirmButton.layer.cornerRadius = 10
        return cell
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismissDetail()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "AvailabilityVC")
        let navController = UINavigationController(rootViewController: nextVC)
        self.presentDetail(navController)
    }
}