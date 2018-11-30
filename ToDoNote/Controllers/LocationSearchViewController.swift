//
//  LocationSearchViewController.swift
//  ToDoNote
//
//  Created by Vincent Garde on 30/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationSearchViewController: UIViewController , CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    let locationManager = CLLocationManager()
    var searchResult : [String] = []
    var oldResearch : String = ""
    let geocoder = CLGeocoder()
    var newLocation: String!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchInput: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
        cell.textLabel?.text = self.searchResult[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.newLocation = self.searchResult[indexPath.row]
        performSegue(withIdentifier: "unwindToEdit", sender: self)
    }
    
    @IBAction func inputValidated(_ sender: Any) {
        if searchInput != nil{
            self.newLocation = self.searchInput.text
            performSegue(withIdentifier: "unwindToEdit", sender: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil && placemarks?.count ?? 0 > 0 {
                let pm = placemarks![0] as CLPlacemark
                if self.searchInput.text == ""{
                    self.searchInput.text = pm.locality
                }
            }
            else {
                print("An error occured while trying to geocode.")
            }
        })
    }
    
    @IBAction func searchInputEdited(_ textField: UITextField) {
        self.searchResult.removeAll()
        if let searchText = textField.text {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = searchText
            let search = MKLocalSearch(request: searchRequest)
            search.start { response, error in
                guard let response = response, error == nil else {
                    print("There was an error searching for \(String(describing: searchRequest.naturalLanguageQuery)) error:\(String(describing: error))")
                    return
                }
                response.mapItems.forEach { mapItem in
                    self.searchResult.append(mapItem.name!)
                    self.tableView.reloadData()
                }
            }
        }
    }    
}
