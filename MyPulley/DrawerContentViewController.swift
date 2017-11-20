import UIKit
import Pulley
import SwiftyJSON

class DrawerContentViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var gripperView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var headerSectionHeightConstraint: NSLayoutConstraint!
    var locations: [Locations] = []
    
    var json = "[ {\"name\":\"Ашан в Авиапарке\",\"address\":\"Москва, Ходынский бульвар, д. 4\",\"longitude\":\"37.533887\",\"latitude\":\"55.789629\"},{\"name\":\"Офис продаж Dubllik\",\"address\":\"Москва, Старопетровский проезд, д. 7А, стр. 25\",\"longitude\":\"37.500881\",\"latitude\":\"55.825558\"}]"
    
    fileprivate var drawerBottomSaveArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSaveArea, right: 0.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        gripperView.layer.cornerRadius = 2.5
        getLocations()
    }
    
    func getLocations() {
        do {
            var encodeString: Data = json.data(using: String.Encoding.utf8)!
            let address = try JSON(data: encodeString).arrayValue
            if !address.isEmpty {
                
                for addr in address {
                    locations.append(Locations(addr["name"].stringValue, addr["address"].stringValue, addr["longitude"].stringValue, addr["latitude"].stringValue))
                }
                
                let utils = Utils()
                let encode: Data = NSKeyedArchiver.archivedData(withRootObject: locations)
                utils.writeObjectToUserDefaults(obj: encode, key: "location")
                
                tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].name
        cell.detailTextLabel?.text = locations[indexPath.row].address
        
        return cell
    }
    
    
}

extension DrawerContentViewController: PulleyDrawerViewControllerDelegate {
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 68.0 + bottomSafeArea
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 264.0 + drawerBottomSaveArea
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all
    }
    
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        
        drawerBottomSaveArea = bottomSafeArea
        
        if drawer.drawerPosition == .collapsed {
            headerSectionHeightConstraint.constant = 68.0 + drawerBottomSaveArea
        } else {
            headerSectionHeightConstraint.constant = 68.0
        }
        
        tableView.isScrollEnabled = drawer.drawerPosition == .open
        
        if drawer.drawerPosition != .open {
            searchBar.resignFirstResponder()
        }
    }
}

extension DrawerContentViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let drawerVC = self.parent as? PulleyViewController {
            drawerVC.setDrawerPosition(position: .open, animated: true)
        }
    }
}


extension DrawerContentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let drawer = self.parent as? PulleyViewController {
//            print("drawer is not nil")
            let prime = self.storyboard?.instantiateViewController(withIdentifier: "PrimaryContentViewController") as! PrimaryContentViewController
            
//            prime.show()
            
            
            PrimaryContentViewController.selectedItem = indexPath.row
            drawer.setPrimaryContentViewController(controller: prime, animated: false)
            
            if drawer.drawerPosition == .open {
                drawer.setDrawerPosition(position: PulleyPosition.partiallyRevealed)
            }
//            prime.showLocation(address: locations, drawer: drawer)
        }
        
        
//        if prime != nil {
//            if prime.mapView == nil {
//                print("mapView is nil")
//            }
//        }
    }
    
}















