//
//  ViewController.swift
//  CustomDrawingApp
//
//  Created by Shagirov Maksat on 15.02.2021.
//

import UIKit

class ViewController: UIViewController {
    var point1: CGPoint?
    var point2: CGPoint!
    var figure: String = "circle"
    var figures: Array<String> = ["circle", "rectangle", "triangle", "line", "pen"]
    @IBOutlet weak var myCustomView: CustomView!
    @IBOutlet weak var undoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longpress = UILongPressGestureRecognizer()
        undoButton.addGestureRecognizer(longpress)
        longpress.addTarget(self, action: #selector(removeAll))
    }
    
    @IBAction func colorPressed(_ sender: UIButton) {
        myCustomView.color = sender.backgroundColor!
    }
    
    @IBAction func figurePressed(_ sender: UIButton) {
        self.figure = figures[sender.tag]
    }
    
    @IBAction func undoButton(_ sender: UIButton) {
        if(!myCustomView.arrayOfFigures.isEmpty) {
            myCustomView.arrayOfFigures.removeLast()
        }
        myCustomView.setNeedsDisplay()
    }
    
    @IBAction func fillSwitch(_ sender: UISwitch) {
        myCustomView.fill = !myCustomView.fill
    }
    
    @objc func removeAll() {
        myCustomView.arrayOfFigures.removeAll()
        myCustomView.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        point1 = touches.first?.location(in: myCustomView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if figure == "pen" {
            point2 = touches.first?.location(in: myCustomView)
            myCustomView.drawLine(p1: point1!, p2: point2)
            point1 = touches.first?.location(in: myCustomView)
        }
        myCustomView.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        point2 = touches.first?.location(in: myCustomView)
        switch(figure) {
        case "circle":
            myCustomView.drawCircle(p1: point1!, p2: point2)
        case "rectangle":
            myCustomView.drawRectangle(p1: point1!, p2: point2)
        case "line":
            myCustomView.drawLine(p1: point1!, p2: point2)
        case "triangle":
            myCustomView.drawTriangle(p1: point1!, p2: point2)
        case "pen":
            myCustomView.drawLine(p1: point1!, p2: point2)
        default:
            break
        }
        myCustomView.setNeedsDisplay()
    }
}
