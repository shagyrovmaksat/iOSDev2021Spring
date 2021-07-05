//
//  AboutUsVC.swift
//  UniApp
//
//  Created by Shagirov Maksat on 11.03.2021.
//

import UIKit

class AboutUsVC: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = UIImage(named: "logo")
        // Do any additional setup after loading the view.
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
