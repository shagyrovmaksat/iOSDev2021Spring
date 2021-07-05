//
//  FacultiesCell.swift
//  UniApp
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit

class FacultiesCell: UITableViewCell {

    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myDiscription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
