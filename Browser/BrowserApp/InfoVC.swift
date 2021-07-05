//
//  InfoVC.swift
//  WebApp
//
//  Created by Maksat on 23.02.2021.
//

import UIKit
import WebKit

class InfoVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var index: Int?
    var main: MainVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ind = index {
            let curUrl = URL(string: (Lists.list[ind].url!))
            let request = URLRequest(url: curUrl!)
            webView.load(request)
            color(ind: ind)
            let tap = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
            tap.numberOfTapsRequired = 3
            view.addGestureRecognizer(tap)
        }
    }
    
    func color(ind: Int) {
        if Lists.list[ind].isFavorite {
            navigationController?.navigationBar.backgroundColor = .yellow
        }
        else {
            navigationController?.navigationBar.backgroundColor = .white
        }
    }

    @objc func tripleTapped() {
        Lists.list[index!].isFavorite = !Lists.list[index!].isFavorite
        if let ind = index {
            color(ind: ind)
        }
        main!.updateTVC()
    }
}
