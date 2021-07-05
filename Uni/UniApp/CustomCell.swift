//
//  CustomCell.swift
//  UniApp
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var discription : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
