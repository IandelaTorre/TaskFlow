//
//  APIClient.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 22/12/25.
//

import Foundation
import Alamofire

final class APIClient {
    private let session: Session
    private let baseURL: String
    
    init(session: Session, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func post<T: Decodable, Body: Encodable>(
        _ path: String,
        body: Body
    ) async throws -> (value: T, headers: HTTPHeaders) {
        let url = baseURL + path
        let decoder = Self.makeJSONDecoder()
        
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<(value: T, headers: HTTPHeaders), Error>) in
            session.request(url,
                            method: .post,
                            parameters: body,
                            encoder: JSONParameterEncoder.default
            )
            .responseData { response in
                let headers = response.response?.headers ?? HTTPHeaders()
                let statusCode = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    guard let code = statusCode else {
                        continuation.resume(throwing: APIError.unknown)
                        return
                    }
                    if (200...299).contains(code) {
                        do {
                            let decoded = try decoder.decode(T.self, from: data)
                            continuation.resume(returning: (decoded, headers))
                        } catch {
                            continuation.resume(throwing: APIError.decoding(error))
                        }
                    } else {
                        do {
                            let problem = try decoder.decode(ProblemDetailsDTO.self, from: data)
                            print("APIError (problem): \(problem)")
                            continuation.resume(throwing: APIError.http(status: code, problem: problem))
                        } catch {
                            print("APIClient (problem decode error): \(error)")
                            continuation.resume(throwing: APIError.http(status: code, problem: nil))
                        }
                    }

                    
                case .failure(let afError):
                    continuation.resume(throwing: APIError.transport(afError))

                }
            }
        }
    }
    
    private static func makeJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
