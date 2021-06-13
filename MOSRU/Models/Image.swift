
import Foundation

struct Image {
    var id: String
    var title: String
    var copyright: String
    var original: Original
    var thumb: Thumb

    init() {
        self.id = ""
        self.title = ""
        self.copyright = ""
        self.original = Original()
        self.thumb = Thumb()
    }
    
    init(_ params: [String: Any]) {
        self.init()
        self.id = params["id"] as? String ?? ""
        self.title = params["title"] as? String ?? ""
        self.copyright = params["copyright"] as? String ?? ""
        let original = params["original"] as? [String: Any] ?? [String: Any]()
        self.original = Original(original)

        let thumb = params["thumb"] as? [String: Any] ?? [String: Any]()
        self.thumb = Thumb(thumb)
    }
    
}

struct Thumb {
    var id: String
    var title: String
    var src: String
    var width: Int
    var height: Int

    init() {
        self.id = ""
        self.title = ""
        self.src = ""
        self.width = 0
        self.height = 0
    }
    
    init(_ params: [String: Any]) {
        self.init()
        self.id = params["id"] as? String ?? ""
        self.title = params["title"] as? String ?? ""
        self.src = params["src"] as? String ?? ""
        self.width = params["width"] as? Int ?? 0
        self.height = params["height"] as? Int ?? 0
    }
    
}

struct Original {
    var id: String
    var title: String
    var src: String
    var width: Int
    var height: Int

    init() {
        self.id = ""
        self.title = ""
        self.src = ""
        self.width = 0
        self.height = 0
    }
    
    init(_ params: [String: Any]) {
        self.init()
        self.id = params["id"] as? String ?? ""
        self.title = params["title"] as? String ?? ""
        self.src = params["src"] as? String ?? ""
        self.width = params["width"] as? Int ?? 0
        self.height = params["height"] as? Int ?? 0
    }
    
}

