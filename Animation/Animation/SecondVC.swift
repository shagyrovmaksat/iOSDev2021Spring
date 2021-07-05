//
//  SecondVC.swift
//  Animation
//
//  Created by Shagirov Maksat on 01.04.2021.
//

import UIKit

class SecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var phones : [Phone] = [Phone(name: "iPhone 7 Plus", cost: "350$", discription1: "A10 Fusion", discription2: "12MPX"),
                            Phone(name: "Samsung Galaxy S8", cost: "500$", discription1: "Snapdragon 835", discription2: "12MPX"),
                            Phone(name: "LG G4", cost: "400$", discription1: "Snapdragon 808", discription2: "16MPX"),
                            Phone(name: "Nexus 6P", cost: "700$", discription1: "Snapdragon 810", discription2: "12.3MPX"),
                            Phone(name: "HTC One M9", cost: "500$", discription1: "Snapdragon 810", discription2: "12MPX"),
                            Phone(name: "Google Pixel", cost: "650$", discription1: "Snapdragon 821", discription2: "12MPX")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell

        cell?.labelName.text = phones[indexPath.row].name
        cell?.labelCost.text = phones[indexPath.row].cost
        cell?.labelDisOne.text = phones[indexPath.row].discription1
        cell?.labelDisTwo.text = phones[indexPath.row].discription2
        cell?.customHideButton()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true )
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)

        UIView.animate(withDuration: 0.5, delay: 0.3 * Double(indexPath.row), animations: {
                cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
            })
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.reloadData()
        myTableView.separatorStyle = .none
    }
}
