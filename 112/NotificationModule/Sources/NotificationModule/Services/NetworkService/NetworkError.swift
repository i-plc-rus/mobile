//
//  NetworkError.swift
//  
//
//  Created by anbushmanov on 04.11.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidEncodableData
    case invalidResponse
    case requestFailed(_ code: Int)
    case parsingError(_ underlying: Error)
    case emptyResponse
}
