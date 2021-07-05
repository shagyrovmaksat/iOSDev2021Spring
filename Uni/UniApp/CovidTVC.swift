//
//  CovidTVC.swift
//  UniApp
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit

class CovidTVC: UITableViewController {
    
    @IBOutlet var myTableView: UITableView!
    
    var items : [CovidItem] = [CovidItem.init(UIImage.init(named: "covid")!,"DISTANT LEARNING, LEAVING DORMITORY AND OTHER ISSUES. Dear students! Due to the developed unfavourable situation with coronavirus all universities of the country switched to the online learning mode. Starting from March 16, 2020 KBTU transferred to the online form of education. The educational process does not stop, but you do not need to come to the university building as classes will be continued to be conducted in the online format. We provide training with the help of information-communication technologies “Microsoft 365 for education” and “G Suite for education” from Google, make use of Skype, MOODLE, ZOOM, Telegram and e-mail for KBTU students regardless of their whereabouts. All the study materials and weekly tasks are uploaded in the Uninet system. Out-of-town and foreign students, including those residing in the KBTU dormitory and rented apartments can return home if they have such an opportunity. In order to support students in this difficult period, KBTU students were paid out their March monthly study allowance and also social aid for orphan children and children left without parental custody beforehand, on March 16, 2020. Since March 18, 2020 in connection with the imposition of the state of emergency and precautionary measures in the country: 1) At entering the territory of the dormitory, the Security service performs thermometry (temperature control) by means of thermovision device. 2) All students staying at the dormitory are under the quarantine. 3) The access to the territory of the dormitory is restricted until 22:00. 4) Exit from the dormitory is permitted only in order to get to the food shop or a pharmacy. 5) A log book of entrance and leaving times is endorsed at the dormitory entrance post of the Security service; at this it is recommended not to leave the dormitory for more than 1 hour. 6) unauthorized people are not allowed to enter the dormitory. 7) All sports and other group activities are prohibited at the territory of the dormitory. The sports court is closed. 3. It is also important to know that at the imposed state of emergency in the country, work of all trade objects, not related with food produce is limited. Cinemas, theatres, night clubs, sports clubs, exhibitions and other objects of mass gathering are closed. On the part of KBTU students, they must realize the scale of the problem and responsibility during the self-study period.")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellCovid") as? CustomCell2
        cell?.picture.image = items[indexPath.row].picture
        cell?.discription.text = items[indexPath.row].discription
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
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
