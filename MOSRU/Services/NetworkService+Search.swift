
import Foundation

extension NetworkService {
    
    func get_events(params: [String: Any], completionHandler: @escaping NetworkServiceCompletionHandler) {
        guard let url = URL(string: self.baseApiURL.absoluteString+"newsfeed/v4/frontend/json/ru/afisha") else {
            completionHandler(404, [:])
            return
        }
        self.request(url: url, method: .get, params: params, completionHandler: completionHandler)
    }

    func get_detail_event(params: [String: Any], completionHandler: @escaping NetworkServiceCompletionHandler) {
        
        let id = params["id"] as? String ?? "0"
        guard let url = URL(string: self.baseApiURL.absoluteString+"newsfeed/v4/frontend/json/ru/afisha/\(id)") else {
            completionHandler(404, [:])
            return
        }
        self.request(url: url, method: .get, params: params, completionHandler: completionHandler)
    }
    
}
