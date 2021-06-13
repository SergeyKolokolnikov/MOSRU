
import Foundation
import Alamofire

class NetworkService: NSObject {

    static let shared = NetworkService()

    typealias NetworkServiceCompletionHandler = ((Int, [String: Any]) -> Void)
    
    var baseURL: URL {
        let infoDictionary = Bundle.main.infoDictionary ?? [String: Any]()
        let URLScheme = infoDictionary["URL_HOST"] as? String ?? ""
        let baseUrlString = "https://\(URLScheme)"

        if let baseUrl = URL(string: baseUrlString) {
            return baseUrl
        }
        return URL(string: "https://")!
    }
        
    var baseApiURL: URL {
        let infoDictionary = Bundle.main.infoDictionary ?? [String: Any]()
        let URLScheme = infoDictionary["URL_HOST"] as? String ?? ""
        let baseUrlString = "https://\(URLScheme)/api/"

        if let baseUrl = URL(string: baseUrlString) {
            return baseUrl
        }
        return URL(string: "https://")!
    }
    
    private var defaultHeaders: [String: String] = {
        var headers: [String: String] = [:]
        let device  = UIDevice.current
        headers["software"] = "\(device.systemName) \(device.systemVersion)"
        headers["Mobile-Рlatform-Version"] = UIDevice.current.systemVersion
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            headers["Mobile-App-Version"] = version
        }
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        return headers
    }()

    var session: URLSession!

    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue())
    }

    // MARK: -

    func request(url: URL, method: HTTPMethod, params: [String: Any], completionHandler: @escaping NetworkServiceCompletionHandler) {
        var urlString = url.absoluteString

        let handler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if let response = response, let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode as Int
                let responseData = self.handlerData(data)
                completionHandler(statusCode, responseData)
            } else {
                completionHandler(200, ["code": "Error", "message": "\(error?.localizedDescription ?? "")"])
            }
        }

        if method == .get {
            urlString = self.urlStringWithParams(url: url, params: params)
            print("GET \(urlString)")
            self.GETRequest(urlString, completionHandler: handler)
        }

        if method == .post {
            #if DEBUG
            print("POST \(url.absoluteString), params: \(params)")
            #endif

            self.POSTRequest(urlString, params: params, completionHandler: handler)
        }

        if method == .patch {
            #if DEBUG
            print("PATCH \(url.absoluteString), params: \(params)")
            #endif
            self.PATCHRequest(urlString, params: params, completionHandler: handler)
        }
    }

    private func GETRequest(_ urlString: String, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {

        AF.request(
        urlString,
        method: .get,
        parameters: [:],
        encoding: URLEncoding.default,
        headers: HTTPHeaders(defaultHeaders))
        .responseJSON { (response) -> Void in
            completionHandler(response.data, response.response, response.error)
        }
        
    }

    private func PATCHRequest(_ urlString: String, params: [String: Any], completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {

        AF.request(
        urlString,
        method: .patch,
        parameters: params,
        encoding: URLEncoding.default,
        headers: HTTPHeaders(defaultHeaders))
        .responseJSON { (response) -> Void in
            completionHandler(response.data, response.response, response.error)
        }

    }

    private func POSTRequest(_ urlString: String, params: [String: Any], completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {

        AF.request(
        urlString,
        method: .post,
        parameters: params,
        encoding: URLEncoding.default,
        headers: HTTPHeaders(defaultHeaders))
        .responseJSON { (response) -> Void in
            completionHandler(response.data, response.response, response.error)
        }

    }

    private func urlStringWithParams(url: URL, params: [String: Any]) -> String {

        var urlString = url.absoluteString

        var components = URLComponents(string: urlString)!
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            let stringValue = String(describing: value)
            let queryItem = URLQueryItem(name: key, value: stringValue)
            queryItems.insert(queryItem, at: queryItems.count)
        }
        components.queryItems = queryItems
        urlString = components.url!.absoluteString

        return urlString
    }

    func handlerData(_ data: Data) -> [String: Any] {

        var result = [String: Any]()
        do {
            result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [String: Any]()
        } catch {
            print("Error handler data: \(error)")
        }

        return result
    }

}

// MARK: -
extension URLSession {

    func synchronousDataTask(with request: URLRequest) throws -> (data: Data?, response: HTTPURLResponse?) {

        let semaphore = DispatchSemaphore(value: 0)

        var responseData: Data?
        var theResponse: URLResponse?
        var theError: Error?

        dataTask(with: request) { (data, response, error) -> Void in

            responseData = data
            theResponse = response
            theError = error

            semaphore.signal()

            }.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        if let error = theError {
            throw error
        }

        return (data: responseData, response: theResponse as! HTTPURLResponse?)

    }

}

extension NetworkService: URLSessionDelegate {

    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let trust = challenge.protectionSpace.serverTrust {
                completionHandler(.useCredential, URLCredential(trust: trust))
            }
        }
    }

    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print(error?.localizedDescription ?? "")
    }

}
