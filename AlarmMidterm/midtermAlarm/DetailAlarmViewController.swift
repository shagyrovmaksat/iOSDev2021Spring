//
//  DetailAlarmViewController.swift
//  midtermAlarm
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit

class DetailAlarmViewController: UIViewController {
    var delegate : DeleteAlarm?
    var delegateForChange : ChangeAlarm?
    var index : Int?
    var curAlarm : Alarm?
    @IBOutlet weak var myTextFiled: UITextField!
    @IBOutlet weak var myPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextFiled.text = curAlarm?.discription
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let date = dateFormatter.date(from: (curAlarm?.time)!)
        myPicker.datePickerMode = UIDatePicker.Mode.time
        myPicker.date = date!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        delegate?.deleteAlarm(index: index!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePressed(_ sender: Any) {
        let times = myPicker.calendar.dateComponents([.hour, .minute], from: myPicker.date)
        var hour = ""
        var minute = ""
        if times.hour! < 10 {
            hour = "0\(times.hour!)"
        }
        if times.hour! >= 10 {
            hour = "\(times.hour!)"
        }
        if times.minute! < 10 {
            minute = "0\(times.minute!)"
        }
        if times.minute! >= 10 {
            minute = "\(times.minute!)"
        }
        delegateForChange?.changeAlarm(time: hour + ":" + minute, discription: myTextFiled.text!, index: index!)
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
