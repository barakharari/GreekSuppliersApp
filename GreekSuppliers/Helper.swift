//
//  Helper.swift
//  GreekSuppliers
//
//  Created by Barak on 10/11/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import Foundation

var navBarColor = UIColor(red: 237/255.5, green: 41/255.5, blue: 57/255.5, alpha: 1.0)
let backgroundColorArray = [UIColor(red: 201/255.5, green: 126/255.5, blue: 64/255.5, alpha: 1), UIColor(red: 192/255.5, green: 192/255.5, blue: 192/255.5, alpha: 1), UIColor(red: 255/255.5, green: 215/255.5, blue: 0, alpha: 1), UIColor(red: 160/255.5, green: 170/255.5, blue: 191/255.5, alpha: 1.0)]
let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

// Presenting view sideways
extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}


// String manipuation for removing characters
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
