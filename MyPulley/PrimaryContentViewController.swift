//
//  ViewController.swift
//  MyPulley
//
//  Created by Елена Озерова on 13/11/2017.
//  Copyright © 2017 Елена Озерова. All rights reserved.
//

import UIKit
import Pulley
import MapKit

class PrimaryContentViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configMapView()
    }

    func configMapView() {
        mapView.mapType = MKMapType.standard
        
        // 2)
        let location = CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        
        // 3)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        // 4)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "WorldClass Metropolis"
        annotation.subtitle = "3D-Dubllik"
        mapView.addAnnotation(annotation)
    }

}

extension PrimaryContentViewController: PulleyPrimaryContentControllerDelegate {
    
    func makeUIAdjustmentsForFullscreen(progress: CGFloat, bottomSafeArea: CGFloat) {
        
    }
    
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat, bottomSafeArea: CGFloat) {
        if distance <= 268.0 + bottomSafeArea {
            
        } else {
            
        }
    }
}
