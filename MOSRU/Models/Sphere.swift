

import Foundation

struct Sphere {
    var id: Int64
    var title: String
    
    init() {
        self.id = 0
        self.title = ""
    }
    
    init(_ params: [String: Any]) {
        self.init()
        self.id = params["id"] as? Int64 ?? 0
        self.title = params["title"] as? String ?? ""
    }
    
}
