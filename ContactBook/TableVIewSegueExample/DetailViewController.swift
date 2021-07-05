//
//  DetailViewController.swift
//  TableVIewSegueExample
//
//  Created by Shagirov Maksat on 12.02.2021.
//
import UIKit

protocol DeleteProtocol {
    func deleteStudentByIndex(ind: Int)
}

class DetailViewController: UIViewController {
    var name_surname: String?
    var number: String?
    var imagePer: UIImage?
    var ind: Int?
    var delegate: DeleteProtocol?
    var create: AddViewController?
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var telephone: UILabel!
    @IBOutlet weak var imagePerson: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameSurnameLabel.text = name_surname
        telephone.text = number
        imagePerson.image = imagePer
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        delegate?.deleteStudentByIndex(ind: ind!)
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        delegate?.deleteStudentByIndex(ind: ind!)
        if let deg = segue.destination as? AddViewController {
            deg.delegate = (delegate as! SavingProtocol);
        }
    }
}
