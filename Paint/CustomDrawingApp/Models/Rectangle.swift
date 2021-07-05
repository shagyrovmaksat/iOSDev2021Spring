//
//  Rectangle.swift
//  CustomDrawingApp
//
//  Created by Shagirov Maksat on 15.02.2021.
//

import Foundation
import UIKit

class Rectangle: Drawble {
    private var p1: CGPoint
    private var p2: CGPoint
    private var color: UIColor
    private var lineWidth: CGFloat
    private var isFilled: Bool
    
    init(_ p1: CGPoint, _ p2: CGPoint, _ color: UIColor, _ lineWidth: CGFloat, _ isFilled: Bool) {
        self.p1 = p1
        self.p2 = p2
        self.color = color
        self.isFilled = isFilled
        self.lineWidth = lineWidth
    }
    
    func drawPath() {
        if p1.x < p2.x && p1.y < p2.y {
            let rect = CGRect(origin: p1, size: CGSize(width: abs(p2.x-p1.x), height: abs(p2.y-p1.y)))
            let path = UIBezierPath(rect: rect)
            color.set()
            path.lineWidth = lineWidth
            isFilled ? path.fill() : path.stroke()
        }
        else if p1.x > p2.x && p1.y > p2.y {
            let rect = CGRect(origin: p1, size: CGSize(width: -abs(p2.x-p1.x), height: -abs(p2.y-p1.y)))
            let path = UIBezierPath(rect: rect)
            color.set()
            path.lineWidth = lineWidth
            isFilled ? path.fill() : path.stroke()
        }
        else if p1.x > p2.x && p1.y < p2.y {
            let rect = CGRect(origin: p1, size: CGSize(width: -abs(p2.x-p1.x), height: abs(p2.y-p1.y)))
            let path = UIBezierPath(rect: rect)
            color.set()
            path.lineWidth = lineWidth
            isFilled ? path.fill() : path.stroke()
        }
        else {
            let rect = CGRect(origin: p1, size: CGSize(width: abs(p2.x-p1.x), height: -abs(p2.y-p1.y)))
            let path = UIBezierPath(rect: rect)
            color.set()
            path.lineWidth = lineWidth
            isFilled ? path.fill() : path.stroke()
        }
    }
}
