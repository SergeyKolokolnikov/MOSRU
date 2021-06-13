

import Foundation

struct Event {
    var id: String
    var title: String
    var text: String
    var tags: [Tag]
    var spheres: [Sphere]
    var image: Image
    var date_from: String
    var date_to: String
    var free: Bool
    
    init() {
        self.id = ""
        self.title = ""
        self.text = ""
        self.tags = [Tag]()
        self.spheres = [Sphere]()
        self.date_from = ""
        self.date_to = ""
        self.image = Image()
        self.free = false
    }
    
    init(_ params: [String: Any]) {
        self.init()
        let id = params["id"] as? Int64 ?? 0
        self.id = String(id)
        self.title = params["title"] as? String ?? ""
        self.text = params["text"] as? String ?? ""
        self.date_from = params["date_from"] as? String ?? ""
        self.date_to = params["date_to"] as? String ?? ""

        let freeInt = params["free"] as? Int ?? 0
        self.free = freeInt == 1 ? true:false

        let imageItem = params["image"] as? [String: Any] ?? [String: Any]()
        self.image = Image(imageItem)

        self.tags.removeAll()
        let tagItems = params["tags"] as? [[String: Any]] ?? [[String: Any]]()
        for tagItem in tagItems {
            let tag = Tag(tagItem)
            self.tags.append(tag)
        }

        self.spheres.removeAll()
        let sphereItems = params["spheres"] as? [[String: Any]] ?? [[String: Any]]()
        for sphereItem in sphereItems {
            let sphere = Sphere(sphereItem)
            self.spheres.append(sphere)
        }

    }
    

}
