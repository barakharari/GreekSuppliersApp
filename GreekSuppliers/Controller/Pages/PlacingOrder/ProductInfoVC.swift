//
//  ProductInfoVC.swift
//  
//
//  Created by Barak on 10/14/18.
//

import UIKit
import Firebase

protocol CellClickedDelegate: class{
    func clickedCell()
}

class ProductInfoVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CellClickedDelegate {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var backToMainButton: UIButton!
    
    private var price: String!
    private var amount: String!
    private var offerChoice: String!
    private var offerPrice: String!
    
    @IBOutlet weak var tierCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToMainButton.layer.cornerRadius = 7
        
        itemImageView.image = ProductsPageVC.currentOrder.product.image
        itemName.text = ProductsPageVC.currentOrder.product.name
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductsPageVC.currentOrder.product.amounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TierInfo", for: indexPath) as! TierCell
        cell.delegate = self
        cell.tierAmount.text = ProductsPageVC.currentOrder.product.amounts[indexPath.row]
        cell.tierPrice.text = "$" + ProductsPageVC.currentOrder.product.prices[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 100)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goBackAfterChoosingProduct(_ sender: UIButton) {
        for cell in tierCollectionView.visibleCells{
            if let cell = cell as? TierCell{
                if cell.buttonSelected == true{
                    offerChoice = cell.tierAmount.text
                    offerPrice = cell.tierPrice.text?.substring(from: 1)
                }
            }
        }
        // Updating the offer and price in the item for a user
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("users").child(user.uid).child("ProductInfo").child(itemName.text!)
            if let offer = offerChoice, let price = offerPrice{
                let values = ["Offer" : offer, "Price" : price]
                ref.setValue(values)
                dismiss(animated: true, completion: nil)
            } else{
                alert(title: "Must choose an order size", message: "Choose an order size to continue")
            }
        }
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func clickedCell() {
        // When clicking a cell, makes all the other cells a different color
        for cell in tierCollectionView.visibleCells{
            if let cell = cell as? TierCell{
                if cell.buttonSelected == true{
                    cell.acceptButton.setTitle("+", for: .normal)
                    cell.acceptButton.layer.backgroundColor = UIColor.lightGray.cgColor
                    cell.buttonSelected = false
                }
            }
        }
    }
}
