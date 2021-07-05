//
//  SearchViewController.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    var searchingTweets : [Tweet] = []
    var isSearching : Bool?
    var tweets : [Tweet] = []
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isSearching = false
        currentUser = Auth.auth().currentUser
        let parent =  Database.database().reference().child("tweets")
        parent.observe(.value) { [weak self](snapshot) in
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching!{
            return searchingTweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CustomCell
        if isSearching! {
            cell?.content?.text = searchingTweets[indexPath.row].content
            cell?.author?.text = searchingTweets[indexPath.row].author
            cell?.date?.text = searchingTweets[indexPath.row].date
            let hashtag = searchingTweets[indexPath.row].hashtag
            cell?.hashtag?.text = "#" + hashtag!
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchingTweets.removeAll()
            for tweet in tweets {
                if tweet.hashtag?.lowercased().range(of: searchText.lowercased()) != nil{
                    searchingTweets.append(tweet)
                }
            }
            isSearching = true
            if searchText == "" {
                isSearching = false;
            }
            myTableView.reloadData()
        }
}
