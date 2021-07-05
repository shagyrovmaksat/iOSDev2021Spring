//
//  ViewController.swift
//  TableVIewSegueExample
//
//  Created by Shagirov Maksat on 11.02.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DeleteProtocol, SavingProtocol {
    
    func deleteStudentByIndex(ind: Int) {
        students.remove(at: ind)
        myTableView.reloadData()
    }
    
    var students: [Student] = []
//    var students = [Student.init("Wasya Pupkin", "87076547564", UIImage.init(named: "female")!),
//                    Student.init("Darkhan Kuanyshbay", "87786494657", UIImage.init(named: "male")!)]

    @IBOutlet weak var NoContacts: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell
        cell?.studentName.text = students[indexPath.row].name_surname
        cell?.studentGPA.text = students[indexPath.row].gpa
        cell?.studentImageView.image = students[indexPath.row].image
        updateContacts()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
//        navigationController?.pushViewController(detailVC, animated: true)
        myTableView.deselectRow(at: indexPath, animated: true )
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deg = segue.destination as? AddViewController {
            deg.delegate = self;
        }
        
        if let index = myTableView.indexPathForSelectedRow?.row {
            let destination = segue.destination as! DetailViewController
            destination.name_surname = students[index].name_surname
            destination.number = students[index].gpa
            destination.imagePer = students[index].image
            destination.ind = index
            destination.delegate = self
        }
    }
    
    func saveNewContact( name: String, num: String, gen: String) {
        if(gen == "female") {
            students.append(Student.init(name, num, UIImage.init(named: "female")!))
        }
        else {
            students.append(Student.init(name, num, UIImage.init(named: "male")!))
        }
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func updateContacts()
    {
        if students.count == 0
        {
            NoContacts.text = "No contacts"
        }
        else
        {
            NoContacts.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            students.remove(at: indexPath.row)
            tableView.deleteRows(at:  [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
