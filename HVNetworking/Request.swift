//
//  Request.swift
//  HVNetworking
//
//  Created by Hetal Vora on 5/12/20.
//  Copyright © 2020 Hetal Vora. All rights reserved.
//

import Foundation

public enum HVHTTPMethodType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE" //raw values
}


public struct HVHTTPRequest<T: HVAPIResourceParseable> {
    let httpMethod: HVHTTPMethodType
    let httpHeaders: [String: String]?
    let httpBody: Data?
    let httpUrlString: String
    let dataModel: T.Type?
    
    public init(httpMethod: HVHTTPMethodType, httpHeaders: [String: String]?, httpBody: Data?, httpUrlString: String, dataModel: T.Type?) {
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
        self.httpBody = httpBody
        self.httpUrlString = httpUrlString
        self.dataModel = dataModel
    }
}

public protocol HVAPIResourceParseable: Codable {
   // associatedtype Model
}

