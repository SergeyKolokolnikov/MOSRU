
import Foundation

struct CacheService {

    static var shared = CacheService()
    
    var favorites: [String] {
        get {
            return UserDefaults.standard.value(forKey: "favorites") as? [String] ?? [String]()
        }
        set(new) {
            UserDefaults.standard.set(new, forKey: "favorites")
        }
    }
}
