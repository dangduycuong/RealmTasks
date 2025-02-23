//
//  APIClient.swift
//  RealmTasks
//
//  Created by cuongdd on 23/2/25.
//

import Foundation

class APIClient {
    static let shared: APIClient = APIClient()
    
    func getData(with target: APIType, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) {
        let url = createURL(target: target)
        let request = createRequest(url: url, target: target)
        print(request.cURL())
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("\nRESPONSE:")
            data?.printFormatedJSON()
            completionHandler(data, response, error)
        }.resume()
    }
    
    func callApi<T: Codable>(target: APIType, completionHandler: @escaping(T)->()) {
        let url = createURL(target: target)
        let request = createRequest(url: url, target: target)
        print(request.cURL())
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            guard let data = data else { return }
            print("\nRESPONSE:")
            data.printFormatedJSON()
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completionHandler(json)
            } catch let error {
                print("decode error: ", error)
            }
        }.resume()
    }
    
    private func createURL(target: APIType) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = target.scheme
        urlComponent.host = target.host
        urlComponent.path = target.path
        if let queryItems = target.queryItems {
            urlComponent.queryItems = queryItems
        }
        
        guard let url = urlComponent.url else {
            fatalError("Can not get url")
        }
        
        return url
    }
    
    private func createRequest(url: URL, target: APIType) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        var headerFields = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        if let headers = target.headers {
            for header in headers {
                headerFields[header.key] = header.value
            }
        }
        
        if let bodyDictionary = target.bodyDictionary {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyDictionary, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        if let bodyData = target.bodyData {
            do {
                let httpBody = try JSONEncoder().encode(bodyData)
                request.httpBody = httpBody
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        request.httpMethod = target.method
        request.allHTTPHeaderFields = headerFields
        
        return request
    }
}
