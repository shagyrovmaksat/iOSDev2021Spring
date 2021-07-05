//
//  Circle.swift
//  CustomDrawingApp
//
//  Created by Shagirov Maksat on 15.02.2021.
//

import Foundation
import UIKit

class Circle: Drawble {
    private var radius: CGFloat?
    private var circleCenter: CGPoint?
    private var color: UIColor
    private var lineWidth: CGFloat
    private var isFilled: Bool
    private var p1: CGPoint
    private var p2: CGPoint
    
    init(_ p1: CGPoint, _ p2: CGPoint, _ color: UIColor, _ lineWidth: CGFloat, _ isFilled: Bool){
        self.p1 = p1
        self.p2 = p2
        self.color = color
        self.isFilled = isFilled
        self.lineWidth = lineWidth
    }

    func drawPath(){
        radius = sqrt(pow(p2.x-p1.x, 2)+pow(p2.y-p1.y, 2))/2
        circleCenter = CGPoint(x: p2.x+(p1.x-p2.x)/2, y: p2.y+(p1.y-p2.y)/2)
        let path = UIBezierPath(arcCenter: circleCenter!, radius: radius!, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        
        color.set()
        path.lineWidth = lineWidth
        isFilled ? path.fill() : path.stroke()
    }
}
