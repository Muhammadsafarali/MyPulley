import UIKit
import Pulley
import MapKit

class PrimaryContentViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var controlsContainer: UIView!
    
    var annotations: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlsContainer.layer.cornerRadius = 10.0
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let drawer = self.parent as? PulleyViewController
        {
            drawer.drawerBackgroundVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        }

//        let utils = Utils()
//        let decode: Data = utils.readObjectFromUserDefaults(key: "mapView")!
//        let address: [Locations] = NSKeyedUnarchiver.unarchiveObject(with: decode) as! [Locations]
        configMapView()
        
        print("viewWillAppear")
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("mapViewWillStartRenderingMap")
    }
    
//    func changeLocation() {
//        let location = CLLocationCoordinate2D(latitude: Double(address[i].latitude!)!, longitude: Double(address[i].longitude!)!)
//
//        // 3)
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegion(center: location, span: span)
//        self.mapView.setRegion(region, animated: true)
//
//        // 4)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = address.name
//        annotation.subtitle = address.address
//        self.mapView.addAnnotation(annotation)
//
//        self.mapView.showsUserLocation = true
//    }
    
    func configMapView() {
        var name = "WorldClass Metropolis"
        var addr = "3D-Dubllik"
        var longitude = "55.751244"
        var latitude = "37.618423"
        
        var address: [Locations] = []
        
        
        let utils = Utils()
        let decode: Data? = utils.readObjectFromUserDefaults(key: "location")
        if decode != nil {
            address = NSKeyedUnarchiver.unarchiveObject(with: decode!) as! [Locations]


//            if address != nil {
//                name = address.name!
//                addr = address.address!
//                latitude = Double(address.latitude!)!
//                longitude = Double(address.longitude!)!
//            }
        } else {
            address.append(Locations(name, addr, longitude, latitude))
        }
        
        for addr in address {
            mapView.mapType = MKMapType.standard
            mapView.showsCompass = false

            // 2)
            let location = CLLocationCoordinate2D(latitude: Double(addr.longitude!)!, longitude: Double(addr.latitude!)!)

            // 3)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)

            // 4)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = addr.name
            annotation.subtitle = addr.address
            mapView.addAnnotation(annotation)
            
            annotations.append(annotation)
        }
        
        self.mapView.selectAnnotation(annotations[0], animated: true)
        self.mapView.centerCoordinate = annotations[0].coordinate
//        let utils = Utils()
        let encode: Data = NSKeyedArchiver.archivedData(withRootObject: mapView)
        utils.writeObjectToUserDefaults(obj: encode, key: "mapView")
        
//        let encodeData: Data = NSKeyedArchiver.archivedData(withRootObject: annotations)
//        utils.writeObjectToUserDefaults(obj: encodeData, key: "annotations")
    }
    
    func show() {
        let temp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrimaryContentViewController") as UIViewController
//        self.presentedViewController(temp, animated: true, completion: nil)
        self.present(temp, animated: true, completion: nil)
        if mapView == nil {
            print("MapView is nil")
        } else {
            print("MapView is not nil")
            
            var name = "WorldClass Metropolis"
            var addr = "3D-Dubllik"
            var longitude = "55.751244"
            var latitude = "37.618423"
            
            let location = CLLocationCoordinate2D(latitude: Double(longitude)!, longitude: Double(latitude)!)
            
            // 3)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
            // 4)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = name
            annotation.subtitle = addr
            mapView.addAnnotation(annotation)
            // https://stackoverflow.com/questions/35544221/accessing-my-mapview-var-from-another-function-mapview-nil
        }
        
    }

    func showLocation(address: [Locations], drawer: PulleyViewController) {
        
//        print(address.name)
        
//        let utils = Utils()
//        let decode: Data = utils.readObjectFromUserDefaults(key: "mapView")!
//        self.mapView = NSKeyedUnarchiver.unarchiveObject(with: decode) as! MKMapView
        
//        let decodeData: Data = utils.readObjectFromUserDefaults(key: "annotations")!
//        self.annotations = NSKeyedUnarchiver.unarchiveObject(with: decodeData) as! [MKPointAnnotation]
        
//        var center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(address[1].longitude!)!, longitude: Double(address[1].latitude!)!)
//        center.latitude -= self.mapView.region.span.latitudeDelta * 0.40
//        self.mapView.setCenter(center, animated: true)
        
        drawer.setPrimaryContentViewController(controller: self, animated: true)
//        let decodeData: Data? = utils.readObjectFromUserDefaults(key: "location")
//        let address = NSKeyedUnarchiver.unarchiveObject(with: decodeData!) as! [Locations]
//        for addr in address {
//            let location = CLLocationCoordinate2D(latitude: Double(addr.longitude!)!, longitude: Double(addr.latitude!)!)
//
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = location
//            annotation.title = addr.name
//            annotation.subtitle = addr.address
//            self.annotations.append(annotation)
//        }
        
//        self.mapView.selectAnnotation(annotations[0], animated: true)
//        self.reloadInputViews()

//        for addr in address {
//            let location = CLLocationCoordinate2D(latitude: Double(addr.latitude!)!, longitude: Double(addr.longitude!)!)
//
//            // 3)
//            let span = MKCoordinateSpanMake(0.05, 0.05)
//            let region = MKCoordinateRegion(center: location, span: span)
//            self.mapView.setRegion(region, animated: true)
//
//            // 4)
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = location
//            annotation.title = addr.name
//            annotation.subtitle = addr.address
//            self.mapView.addAnnotation(annotation)
//
//            self.mapView.showsUserLocation = true
//        }
        
        
//        let utils = Utils()
//        let encode: Data = NSKeyedArchiver.archivedData(withRootObject: address)
//        utils.writeObjectToUserDefaults(obj: encode, key: "location")
        
        //if let drawer = self.parent as? PulleyViewController {
//        let primaryContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrimaryContentViewController")
        //        drawer.setPrimaryContentViewController(controller: primaryContent, animated: true)
        
        
        
//            if self.mapView == nil {
//                print("MapView is nil")
//            }
        //}
//        let utils = Utils()
//        let decode: Data = utils.readObjectFromUserDefaults(key: "mapView")!
//        self.mapView = NSKeyedUnarchiver.unarchiveObject(with: decode) as! MKMapView
//
//        let location = CLLocationCoordinate2D(latitude: Double(address.latitude!)!, longitude: Double(address.longitude!)!)
//
//        // 3)
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegion(center: location, span: span)
//        self.mapView.setRegion(region, animated: true)
//
//        // 4)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = address.name
//        annotation.subtitle = address.address
//        self.mapView.addAnnotation(annotation)
//
//        self.mapView.showsUserLocation = true
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
