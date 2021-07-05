//
//  SitesVC.swift
//  WebApp
//
//  Created by Maksat on 23.02.2021.
//

import UIKit

class MainVC: UITableViewController {
    
    @IBOutlet weak var mySegmentControl: UISegmentedControl!

    private var array: [Page] = []
    var nameOfPage: UITextField?
    var urlOfPage: UITextField?
    var curList: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        array = Lists.list
        navigationItem.title = "Websites"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Lists.list.remove(at: indexPath.row)
            array = updateList()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let navcon = segue.destination as? UINavigationController,
               let destination = navcon.visibleViewController as? InfoVC,
               let row = tableView.indexPathForSelectedRow?.row {
                destination.index = row
                destination.main = self
                destination.navigationItem.title = array[row].name
            }
        }
    }

    @IBAction func segmentedControllAction(_ sender: UISegmentedControl) {
        self.updateTVC()
    }
    
    func updateList()->[Page] {
        if mySegmentControl.selectedSegmentIndex == 0 {
            return Lists.list
        }
        var temp: [Page] = []
        for i in Lists.list {
            if i.isFavorite {
                temp.append(i)
            }
        }
        return temp
    }

    func updateTVC() {
        array = updateList()
        tableView.reloadData()
    }

    @IBAction func alertOpen(_ sender: UIBarButtonItem) {
        let alertControl = UIAlertController(title: "Add website", message: nil, preferredStyle: .alert)
        alertControl.addTextField(configurationHandler: name)
        alertControl.addTextField(configurationHandler: url)

        let canselAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertControl.addAction(canselAction)
        let addAction = UIAlertAction(title: "Add", style: .default, handler: self.addButton)
        alertControl.addAction(addAction)

        self.present(alertControl, animated: true)
    }

    func name(textField: UITextField) {
        nameOfPage = textField
        nameOfPage?.placeholder = "Enter name"
    }

    func url(textField: UITextField) {
        urlOfPage = textField
        urlOfPage?.placeholder = "Enter url"
    }

    func addButton(alert: UIAlertAction) {
        let page = Page(name: (nameOfPage?.text)!, url: (urlOfPage?.text)!)
        
        if !havePage(page: page) {
            Lists.list.append(page)
            updateTVC()
        }
        else {
            let alertControl = UIAlertController(title: "This website is already available", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertControl.addAction(okAction)
            self.present(alertControl, animated: true)
        }
    }
    
    func havePage(page: Page)-> Bool {
        for i in Lists.list {
            if i.name == page.name && i.url == page.url {
                return true
            }
        }
        return false
    }
}
