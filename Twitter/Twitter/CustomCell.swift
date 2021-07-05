//
//  CustomCell.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var hashtag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
