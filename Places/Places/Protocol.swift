//
//  Protocol.swift
//  Places
//
//  Created by Shagirov Maksat on 25.03.2021.
//

import Foundation
import MapKit

protocol EditPlace {
    func editPlace(annotation : MKPointAnnotation, title : String, subtitle : String)
}
