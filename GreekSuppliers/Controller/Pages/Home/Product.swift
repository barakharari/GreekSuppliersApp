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
    var bronzeAmount: Int!
    var bronzePrice: Int!
    var silverAmount: Int!
    var silverPrice: Int!
    var goldAmount: Int!
    var goldPrice: Int!
    var platinumAmount: Int!
    var platinumPrice: Int!
    var imageDownloadURL: String!
    
    init(name: String, snapshot: DataSnapshot){
        self.name = name
        if let products = snapshot.value as? [String: AnyObject]{
            loadImageUrl(products: products)
        }
    }
    
    func loadImageUrl(products: [String: AnyObject]){
        if let product = products["\(self.name!)"] as? [String: AnyObject]{
            for (key, value) in product{
                if key == "Image"{
                    self.imageDownloadURL = value as? String
                    print(self.imageDownloadURL!)
                } else if key == "Bronze"{
                    self.bronzeAmount = value["Amount"] as? Int
                    self.bronzePrice = value["Price"] as? Int
                } else if key == "Silver"{
                    self.silverAmount = value["Amount"] as? Int
                    self.silverPrice = value["Price"] as? Int
                } else if key == "Gold"{
                    self.goldAmount = value["Amount"] as? Int
                    self.goldPrice = value["Price"] as? Int
                } else if key == "Platinum"{
                    self.platinumAmount = value["Amount"] as? Int
                    self.platinumPrice = value["Price"] as? Int
                }
            }
        }
    }
}


