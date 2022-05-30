//
//  RequestFactory.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation

final class RequestFactory {
    
    enum Method: String {
        case GET
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
