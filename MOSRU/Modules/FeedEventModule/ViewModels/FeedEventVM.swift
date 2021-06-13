
import Foundation

class FeedEventVM: FeedEventDelegate {

    private var action: Action?
    private var events: [Event]
    private var filter: String
    
    init() {
        self.events = [Event]()
        self.filter = ""
    }
    
    convenience init(action: Action, filter: String) {
        self.init()
        self.action = action
        self.filter = filter
    }
    
    func getEnevts(_ completion: @escaping ([Event]) -> Void) {
        var events = [Event]()
        guard let action = self.action else {
            completion(events)
            return
        }
        
        var params = action.params
        params["filter"] = self.filter
        
        NetworkService.shared.get_events(params: params) { (status, result) in
            if status == 200 {
                let items = result["items"] as? [[String: Any]] ?? [[String: Any]]()
                for item in items {
                    events.append(Event(item))
                }
            }
            self.events = events
            completion(events)
            
        }
    }
    
    func getCountAction() -> Int {
        return self.events.count
    }

    func getItem(_ index: Int) -> Event {
        return self.events[index]
    }

}
