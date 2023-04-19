//
//  MockURLSession.swift
//  JPMC MCoE TestTests
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation

class ServiceSessionMock: ServiceSession {
    var data: Data?
    func getWebService(url: URL, params: [String : Any], completionHandler: @escaping ((Result<Data, ServiceError>) -> Void)) {
        if let value = data {
            completionHandler(.success(value))
        }
        completionHandler(.failure(.invalidURL))
    }
}
