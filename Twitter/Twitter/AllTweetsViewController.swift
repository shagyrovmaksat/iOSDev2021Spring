//
//  AllTweetsViewController.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth

class AllTweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var tweets : [Tweet] = []
    var currentUser : User?
    let ref =  Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = Auth.auth().currentUser
        ref.child("tweets").observe(.value) { [weak self](snapshot) in
            self?.tweets.removeAll()
            for child in snapshot.children {
                if let snap = child as? DataSnapshot {
                    let tweet = Tweet(snapshot: snap)
                    self?.tweets.append(tweet)
                }
            }
            self?.tweets.reverse()
            self?.myTableView.reloadData()
        }
    }
    
    @IBAction func compose(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New tweet", message: "Enter a text", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "What's up"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Hashtag"
        }

        alert.addAction(UIAlertAction(title: "Tweet", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let hashtag = alert?.textFields![1]
            let curDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let newDate = dateFormatter.string(from: curDate)
            let tweet = Tweet(textField!.text!, (self.currentUser?.email)!, newDate, hashtag!.text!)
            self.ref.child("tweets").childByAutoId().setValue(tweet.dict)
            self.tweets.append(tweet)
            self.myTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in
            alert.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CustomCell
        cell?.content?.text = tweets[indexPath.row].content
        cell?.author?.text = tweets[indexPath.row].author
        cell?.date?.text = tweets[indexPath.row].date
        let hashtag = tweets[indexPath.row].hashtag
        cell?.hashtag?.text = "#" + hashtag!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
}
