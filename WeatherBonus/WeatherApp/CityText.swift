//
//  CityText.swift
//  WeatherApp
//
//  Created by Shagirov Maksat on 20.04.2021.
//

import Foundation
import SwiftUI

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}
