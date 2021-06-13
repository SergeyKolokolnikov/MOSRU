

import Foundation

struct Tag {
    var id: String
    var title: String
    
    init() {
        self.id = ""
        self.title = ""
    }
    
    init(_ params: [String: Any]) {
        self.init()
        self.id = params["id"] as? String ?? ""
        self.title = params["title"] as? String ?? ""
    }
    
}
