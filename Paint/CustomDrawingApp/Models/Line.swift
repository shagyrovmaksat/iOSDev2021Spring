//
//  Line.swift
//  CustomDrawingApp
//
//  Created by Shagirov Maksat on 15.02.2021.
//

import Foundation
import UIKit

class Line: Drawble {
    private var p1: CGPoint
    private var p2: CGPoint
    private var color: UIColor
    private var lineWidth: CGFloat
    
    init(_ p1: CGPoint, _ p2: CGPoint, _ color: UIColor, _ lineWidth: CGFloat){
        self.p1 = p1
        self.p2 = p2
        self.color = color
        self.lineWidth = lineWidth
    }
    
    func drawPath(){
        let path = UIBezierPath()
        
        path.move(to: p1)
        path.addLine(to: p2)
        path.close()
        
        color.set()
        path.lineWidth = lineWidth
        path.stroke()
    }
}
