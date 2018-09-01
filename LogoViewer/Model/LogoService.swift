//
//  LogoService.swift
//  LogoViewer
//
//  Created by Mickael on 01/09/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import Foundation

class LogoService {
    
    static let shared = LogoService()
    private init(){}
    
    private var task: URLSessionDataTask?
    private var stringUrl = "https://logo.clearbit.com/"
    
    func getLogo(domain: String, callback: @escaping (Bool, Data?) -> Void) {
        let session = URLSession(configuration: .default)
        let stringUrlAsked = "\(stringUrl)\(domain)"
        let logoUrl = URL(string: stringUrlAsked)!
        task?.cancel()
        task = session.dataTask(with: logoUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                callback(true, data)
            }
        }
        task?.resume()
    }
    
}
