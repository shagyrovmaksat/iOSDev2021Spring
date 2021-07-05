//
//  ViewController.swift
//  Places
//
//  Created by Shagirov Maksat on 23.03.2021.
//

import UIKit
import MapKit
import CoreData

class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}

class ViewController: UIViewController, MKMapViewDelegate, EditPlace {
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var noPlacesLabel: UILabel!
    
    var selectedAnnotation: MKPointAnnotation?
    
    var mapType: [Int: MKMapType] = [0 : .standard, 1 : .hybrid, 2 : .satellite]
    
    var places: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        
        do {
            places = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error). \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.delegate = self
        myMap.mapType = .standard
        myTableView.isHidden = true
        viewWillAppear(true)
        showData(places)
        myTableView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    func showData(_ places: [NSManagedObject]) {
        for place in places {
            let annotation =  MyPointAnnotation()
            annotation.pinTintColor = .blue
            annotation.coordinate.latitude = place.value(forKey: "latitude") as! CLLocationDegrees
            annotation.coordinate.longitude = (place.value(forKey: "longitude") as! CLLocationDegrees)
            annotation.title = place.value(forKey: "title") as? String
            annotation.subtitle = place.value(forKey: "subtitle") as? String
            myMap.addAnnotation(annotation)
        }
    }
    
    func editPlace(annotation : MKPointAnnotation, title : String, subtitle : String) {
        let coordinate = annotation.coordinate
        let indexInPlaces = places.firstIndex(where: { ($0.value(forKey: "title") as! String) == annotation.title})!

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        removeSpecificAnnotation(title: annotation.title!)
        managedContext.delete(places[indexInPlaces])
        do {
            try managedContext.save()
//            myTableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error). \(error.userInfo)")
        }
        
        places.remove(at: indexInPlaces)

        let annotation = MyPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = coordinate
        annotation.pinTintColor = .blue
        myMap.addAnnotation(annotation)
        save(title: annotation.title!, subtitle: annotation.subtitle!, latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        myTableView.reloadData()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
            annotationView!.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            button.addTarget(self, action:#selector(editAnnotation), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }

        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
        }
//        navigationTitle.title = (annotation.title as! String)
        return annotationView
    }
    
    @objc func editAnnotation(sender: UIButton) {
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditVC") as! EditVC
        editVC.annotation = selectedAnnotation
        editVC.editPlace = self
        show(editVC, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
        self.navigationTitle.title = selectedAnnotation?.title
    }
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        myMap.mapType = mapType[sender.selectedSegmentIndex] ?? .standard
    }
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: self.myMap)
        let coordinate = self.myMap.convert(touchPoint, toCoordinateFrom: self.myMap)
        
        let alertController = UIAlertController(title: "New Location", message: "Fill the fields", preferredStyle: .alert)
        alertController.addTextField { (textfiled) in
            textfiled.placeholder = "Location"
        }
        alertController.addTextField { (textfiled) in
            textfiled.placeholder = "Description"
        }
        let save = UIAlertAction(title: "OK", style: .default) { [weak self](alert) in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            
            let annotation = MyPointAnnotation()
            annotation.title = firstTextField.text
            annotation.subtitle = secondTextField.text
            annotation.coordinate = coordinate
            annotation.pinTintColor = .blue
            self?.myMap.addAnnotation(annotation)
            self?.save(title: annotation.title!, subtitle: annotation.subtitle!, latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            self?.myTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(save)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func save(title : String, subtitle : String, latitude: Double, longitude: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: managedContext)!
        
        let place = NSManagedObject(entity: entity, insertInto: managedContext)
        
        place.setValue(title, forKey: "title")
        place.setValue(subtitle, forKey: "subtitle")
        place.setValue(latitude, forKey: "latitude")
        place.setValue(longitude, forKey: "longitude")
        do {
            try managedContext.save()
            places.append(place)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func leftPressed(_ sender: UIButton) {
        if (self.myMap?.annotations.count != 0 ) {
            if let selectedAnnotation = selectedAnnotation {
                let indexInPlaces = places.firstIndex(where: { ($0.value(forKey: "title") as! String) == selectedAnnotation.title! && ($0.value(forKey: "subtitle") as! String) == selectedAnnotation.subtitle})!
                
                if (indexInPlaces == 0) {
                    let index = self.myMap.annotations.firstIndex(where: {$0.title! == (places[places.count - 1].value(forKey: "title") as! String) && $0.subtitle! == (places[places.count - 1].value(forKey: "subtitle") as! String)})
                    
                    self.myMap.selectAnnotation(self.myMap.annotations[index!], animated: true)
                }
                else {
                    let index = self.myMap.annotations.firstIndex(where: {$0.title! == (places[indexInPlaces-1].value(forKey: "title") as! String) && $0.subtitle! == (places[indexInPlaces-1].value(forKey: "subtitle") as! String)})
                    
                    self.myMap.selectAnnotation(self.myMap.annotations[index!], animated: true)
                }
            }
        }
    }
    
    @IBAction func rightPressed(_ sender: UIButton) {
        if (self.myMap?.annotations.count != 0 ) {
            if let selectedAnnotation = selectedAnnotation {
                let indexInPlaces = places.firstIndex(where: { ($0.value(forKey: "title") as! String) == selectedAnnotation.title! && ($0.value(forKey: "subtitle") as! String) == selectedAnnotation.subtitle})!
                
                if (indexInPlaces == places.count - 1) {
                    let index = self.myMap.annotations.firstIndex(where: {$0.title! == (places[0].value(forKey: "title") as! String) && $0.subtitle! == (places[0].value(forKey: "subtitle") as! String)})
                    
                    self.myMap.selectAnnotation(self.myMap.annotations[index!], animated: true)
                }
                else {
                    let index = self.myMap.annotations.firstIndex(where: {$0.title! == (places[indexInPlaces+1].value(forKey: "title") as! String) && $0.subtitle! == (places[indexInPlaces+1].value(forKey: "subtitle") as! String)})
                    
                    self.myMap.selectAnnotation(self.myMap.annotations[index!], animated: true)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = place.value(forKey: "title") as? String
        cell.detailTextLabel?.text = place.value(forKey: "subtitle") as? String
//        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            removeSpecificAnnotation(title: self.places[indexPath.row].value(forKey: "title") as! String)
            managedContext.delete(places[indexPath.row])
            do {
                try managedContext.save()
                myTableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error). \(error.userInfo)")
            }
            
            places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        if(places.count != 0) {
            noPlacesLabel.isHidden = true
        } else {
            noPlacesLabel.isHidden = false
        }
    }
    
    @IBAction func oraganizePressed(_ sender: UIBarButtonItem) {
        
        if(places.count != 0) {
            noPlacesLabel.isHidden = true
        } else {
            noPlacesLabel.isHidden = false
        }
        
        self.myTableView.reloadData()
        if (myTableView.isHidden == true) {
            myTableView.isHidden = false
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = myMap.bounds
            myMap.addSubview(blurView)
        } else {
            myTableView.isHidden = true
            myMap.subviews[myMap.subviews.count - 1].removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.isHidden = true
        myMap.subviews[myMap.subviews.count - 1].removeFromSuperview()
        let index = self.myMap?.annotations.firstIndex(where: {$0.title == (places[indexPath.row].value(forKey: "title") as! String)})!
        self.myMap?.selectAnnotation(self.myMap.annotations[index!], animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func removeSpecificAnnotation(title : String) {
        for annotation in self.myMap.annotations {
            if annotation.title == title {
                self.myMap.removeAnnotation(annotation)
                break
            }
        }
    }
}
