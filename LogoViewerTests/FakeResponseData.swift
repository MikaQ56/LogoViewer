//
//  FakeResponseData.swift
//  LogoViewerTests
//
//  Created by Mickael on 03/09/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class LogoError: Error {}
    
    let error = LogoError()
    
    let imageData = "image".data(using: .utf8)!
}
