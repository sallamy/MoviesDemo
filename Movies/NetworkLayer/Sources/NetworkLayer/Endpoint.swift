//
//  File.swift
//  
//
//  Created by mohamed salah on 16/01/2024.
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol TargetType {
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var baseURL: String { get }
}


