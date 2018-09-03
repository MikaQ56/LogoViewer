//
//  URLSessionFake.swift
//  LogoViewerTests
//
//  Created by Mickael on 03/09/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
    
    var imageData: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.imageData = data
        self.response = response
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.imageData = imageData
        task.urlResponse = response
        task.responseError = error
        return task
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.imageData = imageData
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
   
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var imageData: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        completionHandler?(imageData, urlResponse, responseError)
    }
    
    override func cancel() {}
}
