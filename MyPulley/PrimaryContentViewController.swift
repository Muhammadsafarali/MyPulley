import UIKit
import Pulley
import MapKit

class PrimaryContentViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var controlsContainer: UIView!
    public static var selectedItem = 0
    
    var annotations: [MKPointAnnotation] = []
    public var addresses: [Locations] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlsContainer.layer.cornerRadius = 10.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let drawer = self.parent as? PulleyViewController
//        {
//            drawer.drawerBackgroundVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//        }

        configMapView()
    }
    
    
    func configMapView() {
        var name = "Офис продаж Dubllik"
        var addr = "Москва, Старопетровский проезд, д. 7А, стр. 25"
        var longitude = "37.500881"
        var latitude = "55.825558"
        

        if addresses.count == 0 {
            addresses.append(Locations(name, addr, longitude, latitude))
        }
        
        for addr in addresses {
            mapView.mapType = MKMapType.standard
            mapView.showsCompass = false

            // 2)
            var location = CLLocationCoordinate2D(latitude: Double(addr.latitude!)!, longitude: Double(addr.longitude!)!)
            
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
        
        // Выбрать location и annotation. (т.е. установка фокуса)
        self.mapView.selectAnnotation(annotations[PrimaryContentViewController.selectedItem], animated: true)
        self.mapView.centerCoordinate = annotations[PrimaryContentViewController.selectedItem].coordinate
        
        // Немного сместить центр карты выше, чтобы видно было location и annotation
        var center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(addresses[PrimaryContentViewController.selectedItem].latitude!)!, longitude: Double(addresses[PrimaryContentViewController.selectedItem].longitude!)!)
        center.latitude -= self.mapView.region.span.latitudeDelta * 0.20
        self.mapView.setCenter(center, animated: false)
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
