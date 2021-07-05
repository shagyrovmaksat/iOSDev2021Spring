//
//  ViewController.swift
//  midtermAlarm
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit

class ViewController: UITableViewController, AddAlarm, DeleteAlarm, ChangeAlarm {
    

    @IBOutlet var myTableView: UITableView!
    
    var alarms : [Alarm] = [Alarm.init(time: "18:00", discription: "Date", isSwitched: true), Alarm.init(time: "12:00", discription: "Lunch", isSwitched: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell
        cell?.time.text = alarms[indexPath.row].time
        cell?.discription.text = alarms[indexPath.row].discription
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deg = segue.destination as? NewAlarmViewController {
            deg.delegate = self;
        }
        
        if let deg = segue.destination as? DetailAlarmViewController {
            deg.delegate = self;
            deg.delegateForChange = self;
            let index = (myTableView.indexPathForSelectedRow?.row)!
            deg.curAlarm = alarms[index]
            deg.index = index
        }
    }
    
    func addAlarm(time: String, discription: String) {
        let newAlarm = Alarm.init(time: time, discription: discription, isSwitched: false)
        alarms.append(newAlarm)
        myTableView.reloadData()
    }
    
    func deleteAlarm(index: Int) {
        alarms.remove(at: index)
        myTableView.reloadData()
    }
    
    func changeAlarm(time: String, discription: String, index: Int) {
        alarms[index].discription = discription
        alarms[index].time = time
        myTableView.reloadData()
    }
    
    override func tableView( _ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView( _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

