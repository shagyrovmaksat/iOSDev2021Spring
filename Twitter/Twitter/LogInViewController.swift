//
//  LogInViewController.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser
        if currentUser != nil && currentUser!.isEmailVerified {
            goToMain()
        }
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        let _email = email.text
        let _password = password.text
        indicator.startAnimating()
        indicator.isHidden = false
        if _email != "" && _password != "" {
            Auth.auth().signIn(withEmail: _email!, password: _password!) { [weak self](result, error) in
                self?.indicator.stopAnimating()
                self?.indicator.isHidden = true
                if error == nil {
                    if Auth.auth().currentUser!.isEmailVerified {
                        self?.goToMain()
                    } else {
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                    }
                } else {
                    self?.showMessage(title: "Error", message: "Some problem occured")
                }
            }
        }
    }
    
    func goToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "Main") as? UITabBarController {
            present(mainPage, animated: true, completion: nil)
        }
    }
    
    func showMessage(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
