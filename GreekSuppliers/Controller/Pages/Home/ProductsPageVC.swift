//
//  ProductsPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

struct Product{
    var name: String!
    var image: UIImage!
}

class ProductsPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MenuPageProtocol {
    
    @IBOutlet weak var continueButton: UIButton!

    static var currentProduct: Product!
    
    var productImagesArray = [UIImage(named: "redsolo"), UIImage(named: "koolaid"), UIImage(named: "pongballs"), UIImage(named: "soda"), UIImage(named: "shotcups")]
    var productNameArray = ["Red Solo Cups 16oz", "Kool Aid Punch Mixer", "Pong balls", "Soda", "Shot Cups"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        //Configuration
        cell.productImageView.layer.cornerRadius = 8
        cell.productImageView.layer.borderWidth = 0.5
        cell.productImageView.layer.borderColor = UIColor.lightGray.cgColor
        cell.productName.layer.borderColor = UIColor.lightGray.cgColor
        
        //Assignment
        cell.productName.text = productNameArray[indexPath.row]
        
        cell.productImageView.image = productImagesArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProductInfo") as! ProductInfoVC
        ProductsPageVC.currentProduct = Product(name: productNameArray[indexPath.row], image: productImagesArray[indexPath.row])
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
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        customizeNavBar()
        
        continueButton.layer.cornerRadius = 10
    }
    
    func sideMenu() {
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Regular", size: 14)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
