//
//  RegisterViewController.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var date: UIDatePicker!
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        let _password = password.text
        let _confirmPassword = confirmPassword.text
        
        if _password != _confirmPassword {
            self.showMessage(title: "Warning", message: "Your passwords do not match")
            return
        }
        
        let _email = email.text
        let _name = name.text
        let _surname = surname.text
        
        if _email != "" && _password != "" {
            indicator.startAnimating()
            indicator.isHidden = false
            Auth.auth().createUser(withEmail: _email!, password: _password!) { (result, error) in
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil {
                    if _name != "" && _surname != "" {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let date = dateFormatter.string(from: self.date.date)
                        let userData = [
                        "email": _email!,
                        "surname": _surname!,
                        "date": date,
                        "name": _name!
                        ]
                        Database.database().reference().child("users").child(result!.user.uid).setValue(userData)
                        self.showMessage(title: "Success", message: "Please verify your email")
                    } else {
                        self.showMessage(title: "Warning", message: "Some fields are empty")
                    }
                } else {
                    self.showMessage(title: "Error", message: "Some problem occured")
                    print(error!)
                }
            }
        }
    }
    
    func showMessage(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            if title != "Error" {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToLogIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
