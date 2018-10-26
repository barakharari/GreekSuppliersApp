//
//  Product.swift
//  GreekSuppliers
//
//  Created by Barak on 10/16/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import Foundation
import Firebase

class Product{
    var name: String!
    var image: UIImage!
    var amounts: [String] = []
    var prices: [String] = []
    var imageDownloadURL: String!
    
    init(name: String, snapshot: DataSnapshot){
        self.name = name
        if let products = snapshot.value as? [String: AnyObject]{
            loadData(products: products)
        }
    }
    
    func loadData(products: [String: AnyObject]){
        if let product = products["\(self.name!)"] as? [String: AnyObject]{
            self.imageDownloadURL = product["Image"] as? String
            if let info = product["Pricing"] as? [String: String]{
                for (amount, price) in info{
                    amounts.append(amount)
                    prices.append(price)
                }
            }
        }
    }
}


