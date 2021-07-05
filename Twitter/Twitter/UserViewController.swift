//
//  UserViewController.swift
//  Twitter
//
//  Created by Shagirov Maksat on 16.04.2021.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UpdateProfile {
    
    func update(name: String, surname: String, date: Date) {
        self.surnameAndName.text = surname + " " + name
        
        let ref = Database.database().reference()
        let myUser = ref.child("users/\(self.currentUser!.uid)")
        self.name = name
        self.surname = surname
        myUser.child("name").setValue(name)
        myUser.child("surname").setValue(surname)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.string(from: date)
        self.dateOfBirth.text = "Date of birth: " + newDate
        self.date = newDate
        myUser.child("date").setValue(newDate)
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var surnameAndName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    let ref = Database.database().reference()
    private let storageRef = Storage.storage().reference()
    
    var currentUser : User?
    var myTweets : [Tweet] = []
    
    var name : String?
    var surname : String?
    var date : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = Auth.auth().currentUser
        email.text = (self.currentUser?.email)!
        
        ref.child("users").child(currentUser!.uid).observeSingleEvent(of: .value, with: {[weak self] (snapshot) in
            let value = snapshot.value as? NSDictionary
            self?.surname = value?["surname"] as? String ?? ""
            self?.name = value?["name"] as? String ?? ""
            self?.date = value?["date"] as? String ?? ""
            self?.surnameAndName.text = self!.surname! + " " + self!.name!
            self?.dateOfBirth.text = "Date of birth: " + self!.date!
            }) { (error) in
              print(error.localizedDescription)
          }
        
        ref.child("tweets").observe(.value) { [weak self](snapshot) in
            self?.myTweets.removeAll()
            for child in snapshot.children {
                if let snap = child as? DataSnapshot {
                    let tweet = Tweet(snapshot: snap)
                    if tweet.author == self?.currentUser!.email {
                        self?.myTweets.append(tweet)
                    }
                }
            }
            self?.myTweets.reverse()
            self?.myTableView.reloadData()
        }
        
        let islandRef = storageRef.child("images/\(currentUser!.uid).png")
        islandRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
          if error == nil {
            let image = UIImage(data: data!)
            self.image.image = image
          } else {
            print(error!)
          }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CustomCell
        cell?.content?.text = myTweets[indexPath.row].content
        cell?.author?.text = myTweets[indexPath.row].author
        cell?.date?.text = myTweets[indexPath.row].date
        let hashtag = myTweets[indexPath.row].hashtag
        cell?.hashtag?.text = "#" + hashtag!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { (contextualAction, view, boolValue) in
            let alert = UIAlertController(title: "Edit tweet", message: "Enter a text", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = self.myTweets[indexPath.row].content
            }
            
            alert.addTextField { (textField) in
                textField.text = self.myTweets[indexPath.row].hashtag
            }
            
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak alert] (_) in
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let result = formatter.string(from: date)
                let content = alert?.textFields![0]
                let hashtag = alert?.textFields![1]
                let ref = Database.database().reference()
                let usersRef = ref.child("tweets")
                let queryRef = usersRef.queryOrdered(byChild: "content").queryEqual(toValue: self.myTweets[indexPath.row].content)
                queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    for snap in snapshot.children {
                        let userSnap = snap as! DataSnapshot
                        let uid = userSnap.key
                        print(uid)
                        ref.child("tweets/\(uid)/content").setValue(content?.text)
                        ref.child("tweets/\(uid)/date").setValue(result)
                        ref.child("tweets/\(uid)/hashtag").setValue(hashtag?.text)
                    }
                })
                
                self.myTableView.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
                alert?.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        })
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (contextualAction, view, boolValue) in
            let ref = Database.database().reference()
            let usersRef = ref.child("tweets")
            let queryRef = usersRef.queryOrdered(byChild: "content").queryEqual(toValue: self.myTweets[indexPath.row].content)
            queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key
                    ref.child("tweets/\(uid)").removeValue()
                }
            })
            self.myTweets.remove(at: indexPath.row)
            self.myTableView.deleteRows(at: [indexPath], with: .fade)
            self.myTableView.reloadData()
        })
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeActions
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deg = segue.destination as? EditViewController {
            deg.delegate = self
            deg.name = self.name
            deg.surname = self.surname
            deg.date = self.date
        }
    }
    
    public func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            image.image = img
            guard let imgData = img.pngData() else {return}
            storageRef.child("images/\(self.currentUser!.uid).png").putData(imgData, metadata: nil, completion: { _, error in
                                                                        guard error == nil else {
                                                                        print("Failed")
                                                                        return
                                                                        }
                                                                       })
        }
        picker.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel( _ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoPressed(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
}
