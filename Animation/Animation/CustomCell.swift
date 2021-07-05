//
//  CustomCell.swift
//  Animation
//
//  Created by Shagirov Maksat on 01.04.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCost: UILabel!
    @IBOutlet weak var labelDisOne: UILabel!
    @IBOutlet weak var labelDisTwo: UILabel!
    
    func customHideButton() {
        hideButton.backgroundColor = .clear
        hideButton.layer.cornerRadius = 5
        hideButton.layer.borderWidth = 1
        hideButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func infoPressed(_ sender: Any) {
        UIView.transition(with: flipView, duration: 0.5, options: .transitionFlipFromLeft) { [self] in
            self.flipView.isHidden = false
        }
    }
    
    @IBAction func hidePressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.flipView.frame.origin.x = self.flipView.frame.width
            self.flipView.alpha = 0
        } completion: { (Bool) in
            self.flipView.alpha =  1
            self.flipView.frame.origin.x = 0
            self.flipView.isHidden = true
        }
    }
}
