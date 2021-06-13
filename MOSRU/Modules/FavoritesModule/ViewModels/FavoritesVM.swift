
import Foundation

class FavoritesVM: FavoritesDelegate {

    private var events: [Event]
    
    init() {
        self.events = [Event]()
    }
    
    func getEnevts(_ completion: @escaping ([Event]) -> Void) {
        var resultEvents = [Event]()

        let group = DispatchGroup()
        for item in CacheService.shared.favorites {
            if item.isEmpty {
                continue
            }
            group.enter()
            NetworkService.shared.get_event(params: ["id": item, "expand": "spheres,tags,types"]) { (status, result) in
                if status == 200 {
                    let event = Event(result)
                    resultEvents.append(event)
                }
                group.leave()
            }

        }

        group.notify(queue: .main) {
            self.events = resultEvents
            completion(resultEvents)
        }
    }
    
    func getCountAction() -> Int {
        return self.events.count
    }

    func getItem(_ index: Int) -> Event {
        return self.events[index]
    }

}
