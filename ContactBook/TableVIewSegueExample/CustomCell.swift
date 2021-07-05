//
//  CustomCell.swift
//  TableVIewSegueExample
//
//  Created by Shagirov Maksat on 12.02.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var studentImageView: UIImageView!
    
    @IBOutlet weak var studentName: UILabel!
    
    @IBOutlet weak var studentGPA: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
