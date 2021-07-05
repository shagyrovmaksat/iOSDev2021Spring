//
//  FacultiesTVC.swift
//  UniApp
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit

class FacultiesTVC: UITableViewController {
    
    @IBOutlet var myTableView: UITableView!
    var items: [FacultiesItem] = [FacultiesItem.init("ISE", "International School of Economics", UIImage.init(named: "economic")!),
                                  FacultiesItem.init("KMA", "Kazakhstan Maritime Academy", UIImage.init(named: "ship")!),
                                  FacultiesItem.init("FIT", "Faculty of Informational Technologies", UIImage.init(named: "fit")!),
                                  FacultiesItem.init("BS", "Business School", UIImage.init(named: "money")!),
                                  FacultiesItem.init("FEOGI", "Faculty of Energy and Oil & Gas Industry", UIImage.init(named: "gas")!),
                                  FacultiesItem.init("SCE", "School of Chemical Engineering", UIImage.init(named: "chemistry")!),
                                  FacultiesItem.init("SMC", "School of Mathematics and Cybernetics", UIImage.init(named: "math")!),
                                  FacultiesItem.init("FGGE", "Faculty of Geology and Geological Exploration", UIImage.init(named: "geology")!)]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell2") as? FacultiesCell
        cell?.myName.text = items[indexPath.row].name
        cell?.myDiscription.text = items[indexPath.row].discription
        cell?.myImage.image = items[indexPath.row].image
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
