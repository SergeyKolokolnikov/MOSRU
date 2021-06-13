
import Foundation

class DetailEventVM: DetailEventDelegate {
    
    private var event: Event
    
    init() {
        self.event = Event()
    }
    
    convenience init(event: Event) {
        self.init()
        self.event = event
    }
    
    func getPreviewImage() -> String {
        let imagePath = "\(NetworkService.shared.baseURL)/\(event.image.thumb.src)"
        return imagePath
    }

    func getEvent() -> Event {
        return event
    }
    

}
