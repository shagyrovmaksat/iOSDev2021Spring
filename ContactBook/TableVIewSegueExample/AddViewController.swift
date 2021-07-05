//
//  AddViewController.swift
//  TableVIewSegueExample
//
//  Created by Shagirov Maksat on 12.02.2021.
//

import UIKit

protocol SavingProtocol {
    func saveNewContact(name: String, num: String, gen: String)
}

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerData: [String] = [String]()
    var delegate: SavingProtocol?
    var gen: String = "female"

    @IBOutlet weak var textNumber: UITextField!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var genPicker: UIPickerView!
    
    @IBAction func buttonSave(_ sender: UIButton) {
        delegate!.saveNewContact(name: textName.text!, num: textNumber.text!, gen: gen)
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Connect data:
        self.genPicker.delegate = self
        self.genPicker.dataSource = self
        //data
        pickerData = ["female", "male"]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // The data to return fopr the row and component (column) that's being passed in
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            gen = pickerData[row]
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
