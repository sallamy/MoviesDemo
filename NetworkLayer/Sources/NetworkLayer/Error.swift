//
//  File.swift
//  
//
//  Created by mohamed salah on 16/01/2024.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case decodingFailed
}
