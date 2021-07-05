//
//  NewAlarmViewController.swift
//  midtermAlarm
//
//  Created by Shagirov Maksat on 12.03.2021.
//

import UIKit

class NewAlarmViewController: UIViewController {
    
    @IBOutlet weak var myPicker: UIDatePicker!
    @IBOutlet weak var myTextField: UITextField!
    var delegate: AddAlarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func canselPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
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
        delegate!.addAlarm(time: hour + ":" + minute, discription: myTextField.text!)
        self.dismiss(animated: true, completion: nil)
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
