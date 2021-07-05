//
//  EditViewController.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import UIKit
import Foundation

class EditViewController: UIViewController {
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    
    var delegate : UpdateProfile?
    var name : String?
    var surname : String?
    var date : String?
    
    let dateFormater = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater.dateFormat = "yyyy-MM-dd"
        dateOfBirth.date = dateFormater.date(from: self.date!)!
        nameTF.text = name
        surnameTF.text = surname
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        delegate?.update(name: nameTF.text!, surname: surnameTF.text!, date: dateOfBirth.date)
        self.dismiss(animated: true, completion: nil)
    }
}
