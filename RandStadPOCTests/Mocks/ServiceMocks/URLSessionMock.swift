//
//  URLSessionMock.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
