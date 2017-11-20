import UIKit
import Pulley
import SwiftyJSON

class DrawerContentViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var gripperView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var headerSectionHeightConstraint: NSLayoutConstraint!
    var locations: [Locations] = []
    var filter: [Locations] = []
    var isSearch: Bool = false
    
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
                

                // Удалить старые объекты
//                let usrDef = UserDefaults()
//                usrDef.removeObject(forKey: "location")
//                usrDef.removeObject(forKey: "mapView")
                
//                let utils = Utils()
//                let encode: Data = NSKeyedArchiver.archivedData(withRootObject: locations)
//                utils.writeObjectToUserDefaults(obj: encode, key: "location")
                
                tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearch {
            return locations.count
        } else {
            return filter.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        if !isSearch {
            cell.textLabel?.text = locations[indexPath.row].name
            cell.detailTextLabel?.text = locations[indexPath.row].address
        } else {
            cell.textLabel?.text = filter[indexPath.row].name
            cell.detailTextLabel?.text = filter[indexPath.row].address
        }
        
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearch = true
        filter = searchText.isEmpty ? locations : locations.filter { (item: Locations) -> Bool in
            return (item.address?.lowercased().contains((searchBar.text?.lowercased())!))!
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
    }
    
}


extension DrawerContentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let drawer = self.parent as? PulleyViewController {
            
            // Получить ссылку на PrimaryContentViewController
            let prime = self.storyboard?.instantiateViewController(withIdentifier: "PrimaryContentViewController") as! PrimaryContentViewController
            
            // Использовать исходный список адресов либо отфильтрованный
            if !isSearch {
                prime.addresses = locations
            } else {
                prime.addresses = filter
            }
            
            // Сделать Update ViewController'a
            drawer.setPrimaryContentViewController(controller: prime, animated: false)
            
            // Если TableView открыт на весь экран, то перевести его в полуоткрытое состояние
            if drawer.drawerPosition == .open {
                drawer.setDrawerPosition(position: PulleyPosition.partiallyRevealed)
            }
        }

    }
    
}















