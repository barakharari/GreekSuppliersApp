//
//  ExistingOrdersVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/29/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class ExistingOrdersVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var tapCell: UITapGestureRecognizer!
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismissDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapCell = UITapGestureRecognizer(target: self, action: #selector(self.tappedCell))
        customizeNavBar()
    }

    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ExistingOrdersHeader", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExistingOrderCell", for: indexPath) as! ExistingOrderCell
        cell.existingOrderCollectionView.delegate = cell
        cell.existingOrderCollectionView.dataSource = cell
        cell.addGestureRecognizer(tapCell)
        return cell
    }
    
    @objc func tappedCell(){
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "DealsPageVC") as! DealsPageVC
        let navController = UINavigationController(rootViewController: nextVC)
        self.presentDetail(navController)
    }
}
