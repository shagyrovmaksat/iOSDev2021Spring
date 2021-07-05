//
//  ViewController.swift
//  Animation
//
//  Created by Shagirov Maksat on 31.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nextB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextB.alpha = 0
        nextB.backgroundColor = .clear
        nextB.layer.cornerRadius = 5
        nextB.layer.borderWidth = 1
        nextB.layer.borderColor = UIColor.white.cgColor
        UIView.animate(withDuration: 1) { [self] in
            emailTF.center = CGPoint(x: emailTF.layer.position.x + 200, y: emailTF.layer.position.y)
        }
        UIView.animate(withDuration: 1) { [self] in
            passwordTF.center = CGPoint(x: passwordTF.layer.position.x - 200, y: passwordTF.layer.position.y)
        }
        UIView.animate(withDuration: 1, delay: 1) { [self] in
            nextB.alpha = 1
        }
        // Do any additional setup after loading the view.
    }
}
