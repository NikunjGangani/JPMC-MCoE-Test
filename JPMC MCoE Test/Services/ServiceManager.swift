//
//  ServiceManager.swift
//  JPMC MCoE Test
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation

enum APIState {
    case initial
    case inProgress
    case completed
}

enum API : String {
    static let BaseURL = "\(Bundle.main.object(forInfoDictionaryKey: "BASE_URL") ?? "")"
    case planetList = "planets/"
    var url : URL {
        get{
            return URL(string: API.BaseURL + self.rawValue)!
        }
    }
}

enum ServiceError: Error {
    case noData
    case invalidURL
    case error(error: Error)
}

protocol ServiceSession {
    func getWebService(url: URL, params: [String: Any], completionHandler: @escaping ((Result<Data, ServiceError>) -> Void))
}

extension URLSession: ServiceSession {

    func getWebService(url: URL, params: [String: Any], completionHandler: @escaping ((Result<Data, ServiceError>) -> Void)){
        let urlComp = NSURLComponents(string: url.absoluteString)!
        var items = [URLQueryItem]()
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, let data = data else {
                completionHandler(.failure(.invalidURL))
                return
            }
            completionHandler(.success(data))
        }
        dataTask.resume()
    }
    
}

class ServiceManager {
    private let session: ServiceSession
    init(session: ServiceSession = URLSession.shared) {
        self.session = session
    }
    
    func getWebService(url: URL, params: [String: Any], completionHandler: @escaping ((Result<Data, ServiceError>) -> Void)) {
        session.getWebService(url: url, params: params, completionHandler: completionHandler)
    }
    
}


