//
//  CustomView.swift
//  CustomDrawingApp
//
//  Created by Shagirov Maksat on 15.02.2021.
//

import UIKit
protocol Drawble {
    func drawPath()
}

class CustomView: UIView {
    var fill: Bool = false
    var color = UIColor.black
    var arrayOfFigures: [Drawble] = []

    override func draw(_ rect: CGRect) {
        // Drawing code
        for figure in arrayOfFigures {
            figure.drawPath()
        }
    }
    
    func drawCircle(p1: CGPoint, p2: CGPoint) {
        let circle = Circle(p1, p2, color, 7, fill)
        arrayOfFigures.append(circle)
    }
    
    func drawRectangle(p1: CGPoint, p2: CGPoint) {
        let rectangle = Rectangle(p1, p2, color, 7, fill)
        arrayOfFigures.append(rectangle)
    }
    
    func drawLine(p1: CGPoint, p2: CGPoint) {
        let line = Line(p1, p2, color, 7)
        arrayOfFigures.append(line)
    }
    
    func drawTriangle(p1: CGPoint, p2: CGPoint) {
        let triangle = Triangle(p1, p2, color, 7, fill)
        arrayOfFigures.append(triangle)
    }
}
