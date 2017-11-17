import Foundation

class Locations: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.latitude, forKey: "latitude")
        aCoder.encode(self.longitude, forKey: "longitude")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String else { return nil }
        guard let address = aDecoder.decodeObject(forKey: "address") as? String else { return nil }
        guard let latitude = aDecoder.decodeObject(forKey: "latitude") as? String else { return nil }
        guard let longitude = aDecoder.decodeObject(forKey: "longitude") as? String else { return nil }
        self.init(name, address, latitude, longitude)
    }
    
    
    var name: String?
    var address: String?
    var longitude: String?
    var latitude: String?
    
    init(_ name: String, _ address: String, _ longitude: String, _ latitude: String) {
        self.name = name
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
    }
}
