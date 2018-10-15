//
//  SetDropOffVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/11/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SetDropOffVC: UIViewController {
    
    @IBOutlet weak var locationSelectedLabel: UILabel!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    @IBOutlet weak var currentLocationView: UIView!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var placesClient: GMSPlacesClient!
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
    
    func positionCurrentLocationButton(){
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocationButton)
        currentLocationButton.layer.cornerRadius = 10
        currentLocationButton.layer.borderWidth = 1.0
        currentLocationButton.layer.borderColor = UIColor.gray.cgColor
        let trailingConstraint = currentLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        let bottomConstraint = currentLocationButton.bottomAnchor.constraint(equalTo: currentLocationView.topAnchor, constant: -10)
        let heightConstraint = currentLocationButton.heightAnchor.constraint(equalToConstant: 60)
        let widthConstraint = currentLocationButton.widthAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([trailingConstraint, bottomConstraint, heightConstraint, widthConstraint])
    }
    
    override func viewDidLoad() {
        customizeNavBar()
        
        placesClient = GMSPlacesClient.shared()
        
        // This will eventually be the users school
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        locationViewConstraints()
        positionCurrentLocationButton()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    func locationViewConstraints(){
        currentLocationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocationView)
        currentLocationView.layer.cornerRadius = 10
        let leadingConstraint = currentLocationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        let trailingConstraint = currentLocationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        let bottomConstraint = currentLocationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        let heightConstraint = currentLocationView.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint, heightConstraint])
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                    self.locationSelectedLabel.text = place.formattedAddress
                    GMSCameraUpdate.setCamera(GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0))
                }
            }
        })
    }
}

extension SetDropOffVC: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        locationViewConstraints()
        
        if let adress = place.formattedAddress{
            locationSelectedLabel.text = "\(adress)"
        }
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
