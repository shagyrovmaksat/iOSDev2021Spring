//
//  EditVC.swift
//  Places
//
//  Created by Shagirov Maksat on 25.03.2021.
//

import UIKit
import MapKit

class EditVC: UIViewController {
    var editPlace : EditPlace?
    var annotation : MKPointAnnotation?
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var subtitleTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.text = annotation?.title
        subtitleTF.text = annotation?.subtitle
        // Do any additional setup after loading the view.
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        editPlace?.editPlace(annotation: annotation!, title: titleTF.text!, subtitle: subtitleTF.text!)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
