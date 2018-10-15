//
//  ProductInfoVC.swift
//  
//
//  Created by Barak on 10/14/18.
//

import UIKit

class ProductInfoVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let tierNameArray = ["Bronze", "Silver", "Gold", "Platinum"]
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    let backgroundColorArray = [UIColor(red: 201/255.5, green: 126/255.5, blue: 64/255.5, alpha: 1), UIColor(red: 192/255.5, green: 192/255.5, blue: 192/255.5, alpha: 1), UIColor(red: 255/255.5, green: 215/255.5, blue: 0, alpha: 1), UIColor(red: 160/255.5, green: 170/255.5, blue: 191/255.5, alpha: 1.0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.layer.cornerRadius = 7
        
        itemImageView.image = ProductsPageVC.currentProduct.image
        itemName.text = ProductsPageVC.currentProduct.name
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tierNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TierInfo", for: indexPath) as! TierCell
        cell.tierName.textColor = (backgroundColorArray[indexPath.row])
        cell.tierName.text = tierNameArray[indexPath.row]
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = (backgroundColorArray[indexPath.row]).cgColor
        cell.layer.cornerRadius = 10
        cell.acceptButton.layer.cornerRadius = 10
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

}

