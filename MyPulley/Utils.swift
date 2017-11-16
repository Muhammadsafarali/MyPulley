import Foundation

public class Utils {
    
    public func writeObjectToUserDefaults(obj: Data, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(obj, forKey: key)
        defaults.synchronize()
    }
    
    public func readObjectFromUserDefaults(key: String) -> Data? {
        let defaults = UserDefaults.standard
        let obj = defaults.object(forKey: key) as! Data
        if obj != nil {
            return obj
        }
        
        return nil
    }
    
}
