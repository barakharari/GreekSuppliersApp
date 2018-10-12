//
//  HomeVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/11/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

protocol MenuPageProtocol{
    func sideMenu()
    func customizeNavBar()
}

struct Package{
    let name: String!
    let description: String!
}

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MenuPageProtocol{

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var oneTimePurchaseButton: UIBarButtonItem!
    @IBOutlet weak var packagesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var packagesArray = [Package(name: "Bronze", description: "blah blah blah"), Package(name: "Silver", description: "blah blah blah"), Package(name: "Gold", description: "blah blah blah"), Package(name: "Platinum", description: "blah blah blah")]
    
    var backgroundColorArray = [UIColor(red: 201/255.5, green: 126/255.5, blue: 64/255.5, alpha: 0.5), UIColor(red: 192/255.5, green: 192/255.5, blue: 192/255.5, alpha: 1), UIColor(red: 255/255.5, green: 215/255.5, blue: 0, alpha: 0.75), UIColor(red: 160/255.5, green: 170/255.5, blue: 191/255.5, alpha: 1.0)]
    var buttonColorArray = [UIColor(red: 201/255.5, green: 126/255.5, blue: 64/255.5, alpha: 0.5).cgColor, UIColor(red: 85/255.5, green: 85/255.5, blue: 85/255.5, alpha: 0.5).cgColor, UIColor(red: 193/255.5, green: 170/255.5, blue: 44/255.5, alpha: 1).cgColor, UIColor(red: 152/255.5, green: 162/255.5, blue: 183/255.5, alpha: 0.96).cgColor]
    
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        customizeNavBar()
        
        pageControl.numberOfPages = packagesArray.count

        
        for index in 0..<packagesArray.count{
            frame.origin.x = packagesCollectionView.frame.size.width * CGFloat(index)
            frame.size = packagesCollectionView.frame.size
        }
        
        packagesCollectionView.contentSize = CGSize(width: packagesCollectionView.frame.size.width * CGFloat(packagesArray.count), height: packagesCollectionView.frame.size.height)
        packagesCollectionView.frame.size.width = view.frame.size.width
        
    }
    
    // Scroll View Method
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / packagesCollectionView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func sideMenu(){
        if revealViewController() != nil{
            menuBarButton.target = revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 275
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PackageCell", for: indexPath) as! PackageCell
        
        cell.packageName.text = packagesArray[indexPath.row].name
        cell.packageView.layer.cornerRadius = 10
        cell.packageView.layer.borderWidth = 1.5
        cell.packageView.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.packageView.backgroundColor = backgroundColorArray[indexPath.row]
        cell.confirmationButton.layer.backgroundColor = buttonColorArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
