
import Foundation

struct Day {
    var title: String
    var subtitle: String
    var date: Date
    
    init() {
        self.title = ""
        self.subtitle = ""
        self.date = Date()
    }
    
    init(title: String, subtitle: String, date: Date) {
        self.init()
        self.title = title
        self.date = date
        self.subtitle = subtitle
    }
    
}
