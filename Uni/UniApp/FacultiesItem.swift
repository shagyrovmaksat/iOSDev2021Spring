//
//  FacultiesItem.swift
//  UniApp
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import Foundation
import UIKit
class FacultiesItem {
    var name: String?
    var discription: String?
    var image: UIImage?
    
    init(_ name: String, _ discription: String, _ image: UIImage){
        self.name = name
        self.discription = discription
        self.image = image
    }
}
