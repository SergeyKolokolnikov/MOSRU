
import Foundation

struct Action {
    var title: String
    var params: [String: Any]
    
    init() {
        self.title = ""
        self.params = [String: Any]()
    }
    
    init(title: String, params: [String: Any]) {
        self.init()
        self.title = title
        self.params = params
    }
    
}
