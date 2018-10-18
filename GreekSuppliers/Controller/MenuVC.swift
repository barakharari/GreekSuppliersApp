//
//  MenuVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/11/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

struct Page{
    let image: UIImage!
    let name: String!
    let aClass: AnyClass!
}

class MenuVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var pagesArray = [Page(image: UIImage(named: "menuIcon"), name: "My Order", aClass: ProductsPageVC.self), Page(image: UIImage(named: "menuIcon"), name: "Payment", aClass: PaymentVC.self), Page(image: UIImage(named: "menuIcon"), name: "Brand Ambassador", aClass: BrandAmbassadorVC.self), Page(image: UIImage(named: "menuIcon"), name: "Products", aClass: ProductsVC.self), Page(image: UIImage(named: "menuIcon"), name: "Settings", aClass: SettingsVC.self), Page(image: UIImage(named: "menuIcon"), name: "Help", aClass: HelpVC.self)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuHeader", for: indexPath) as! MenuHeader
        
        let ref = Database.database().reference()
        
        ref.child("user").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.childrenCount > 0{
                for categorys in snapshot.children.allObjects as! [DataSnapshot]{
                    let category = categorys.value as? [String: AnyObject]
                    header.menuHeaderLabel.text = category!["name"] as? String
                }
            }
        }
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pagesArray[indexPath.row].name, for: indexPath) as! MenuCell
        cell.pageLabel.text = pagesArray[indexPath.row].name
        cell.pageIcon.image = pagesArray[indexPath.row].image
        return cell
    }
    


}
