//
//  CovidItem.swift
//  UniApp
//
//  Created by Shagirov Maksat on 12.03.2021.
//
import UIKit
import Foundation

class CovidItem {
    var picture : UIImage?
    var discription : String?
    
    init(_ picture: UIImage, _ discription: String) {
        self.picture = picture
        self.discription = discription
    }
}
