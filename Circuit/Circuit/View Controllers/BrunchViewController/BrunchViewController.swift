//
//  BrunchViewController.swift
//  Circuit
//
//  Created by Djuro Alfirevic on 12/8/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import UIKit
import MapKit

class BrunchViewController: UIViewController, Setup {

    // MARK: - Properties
    @IBOutlet weak var brunchImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    var brunch: Brunch!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        brunchImageView.image = brunch.image
        nameLabel.text = brunch.name
        descriptionLabel.text = brunch.description
        distanceLabel.text = brunch.formattedDistance()
        
        if let review = brunch.review {
            reviewLabel.text = review
        }
    }
    
    // MARK: - Actions
    @IBAction func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func callButtonTapped() {
        if let url = URL(string: "call://") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func saveButtonTapped() {
        presentAlert("Save", message: "Saving successful...")
    }
    
    @IBAction func navigateButtonTapped() {
        openMap()
    }
    
    // MARK: - Private API
    private func openMap() {
        let latitude: CLLocationDegrees = 51.419671
        let longitude: CLLocationDegrees = -0.193487
        
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = brunch.name
        mapItem.openInMaps(launchOptions: options)
    }

}
