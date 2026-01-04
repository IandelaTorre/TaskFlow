//
//  APIError.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 24/12/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case http(status: Int, problem: ProblemDetailsDTO?)
    case decoding(Error)
    case transport(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .http(_, let problem):
            return problem?.detail ?? problem?.title ?? "Request failed"
        case .decoding:
            return "Unable to read response from server. "
        case .transport(let error):
            return error.localizedDescription
        case .unknown:
            return "An unknown error occurred. "
        }
    }
}
