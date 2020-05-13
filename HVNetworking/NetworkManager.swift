//
//  NetworkManager.swift
//  HVNetworking
//
//  Created by Hetal Vora on 5/12/20.
//  Copyright © 2020 Hetal Vora. All rights reserved.
//

import Foundation

public protocol HVNetworkManager {
   // associatedtype Model: Decodable
    func load<T: HVAPIResourceParseable>(httpRequest: HVHTTPRequest<T>, completion:@escaping (T?) -> ())
    func decode<T: HVAPIResourceParseable>(response: HVHTTPResponse, toModel: T.Type) -> T?
}

public extension HVNetworkManager {
    
    func load<T: HVAPIResourceParseable>(httpRequest: HVHTTPRequest<T>, completion:@escaping (T?) -> ()) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = URL(string:  httpRequest.httpUrlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url:url)
        
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let httpurlresponse = response as! HTTPURLResponse
            let response = HVHTTPResponse(responseCode: httpurlresponse.statusCode, responseData: data)
            let model = self.decode(response: response, toModel: T.self)
            completion(model)
            
        })
        
        dataTask.resume()
    
    }
    
    func decode<T: HVAPIResourceParseable>(response: HVHTTPResponse, toModel: T.Type) -> T? {
        let decoder = JSONDecoder.init()

        do {
            let decodedData = try decoder.decode(T.self, from: response.responseData)
           // print(decodedData)
            return decodedData
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
