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

class PrimaryContentViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var controlsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlsContainer.layer.cornerRadius = 10.0
        
        let utils = Utils()
        let encode: Data = NSKeyedArchiver.archivedData(withRootObject: mapView)
        utils.writeObjectToUserDefaults(obj: encode, key: "mapView")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let drawer = self.parent as? PulleyViewController
        {
            drawer.drawerBackgroundVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        }
        configMapView()
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("mapViewWillStartRenderingMap")
    }
    
    func configMapView() {
        mapView.mapType = MKMapType.standard
        mapView.showsCompass = false
        
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

    func showLocation(address: Locations) {

        let utils = Utils()
        let decode: Data = utils.readObjectFromUserDefaults(key: "mapView")!
        self.mapView = NSKeyedUnarchiver.unarchiveObject(with: decode) as! MKMapView
        
        let location = CLLocationCoordinate2D(latitude: Double(address.latitude!)!, longitude: Double(address.longitude!)!)
        
        // 3)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        
        // 4)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = address.name
        annotation.subtitle = address.address
        self.mapView.addAnnotation(annotation)
        
        self.mapView.showsUserLocation = true
    }
    
}

extension PrimaryContentViewController: PulleyPrimaryContentControllerDelegate {
    
    func makeUIAdjustmentsForFullscreen(progress: CGFloat, bottomSafeArea: CGFloat) {
        print("Full Sceen Adjust")
    }
    
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat, bottomSafeArea: CGFloat) {
        if distance <= 268.0 + bottomSafeArea {
            
        } else {
            
        }
    }
}
