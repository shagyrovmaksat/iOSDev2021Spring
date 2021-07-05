//
//  Triangle.swift
//  CustomDrawingApp
//
//  Created by Shagirov Maksat on 15.02.2021.
//

import Foundation
import UIKit

class Triangle: Drawble {
    private var p1: CGPoint
    private var p2: CGPoint
    private var color: UIColor
    private var lineWidth: CGFloat
    private var isFilled: Bool
    
    init(_ p1: CGPoint, _ p2: CGPoint, _ color: UIColor, _ lineWidth: CGFloat, _ isFilled: Bool){
        self.p1 = p1
        self.p2 = p2
        self.color = color
        self.lineWidth = lineWidth
        self.isFilled = isFilled
    }
    
    func drawPath(){
        let path = UIBezierPath()
        
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: CGPoint(x: p1.x, y: p2.y))
        path.addLine(to: p1)
        path.close()
        
        color.set()
        path.lineWidth = lineWidth
        isFilled ? path.fill() : path.stroke()
    }
}
