//
//  apiServiceImpl.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 24/09/2025.
//

import Foundation

final class DefaultAPIClient: APIClient {
    private let interceptors: [RequestInterceptor]
    private let session: URLSession
    
    init(interceptors: [RequestInterceptor] = [],
         session: URLSession = .shared) {
        self.interceptors = interceptors
        self.session = session
    }
    
    // MARK: - Base request
    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T {
        var adaptedRequest = endpoint
        
        // Apply interceptors (adapt phase)
        for interceptor in interceptors {
            adaptedRequest = try await interceptor.adapt(adaptedRequest)
        }
        
        // Notify "will send"
        for interceptor in interceptors {
            interceptor.willSend(adaptedRequest)
        }
        
        var data: Data
        var response: URLResponse
        var error: Error?
        
        // Execute request
        do {
            (data, response) = try await session.data(for: adaptedRequest)
        } catch let e {
            error = e
            // Notify interceptors about error
            for interceptor in interceptors {
                interceptor.didReceive(URLResponse(), data: nil, error: error)
            }
            throw e
        }
        
        // Notify interceptors about response
        for interceptor in interceptors {
            interceptor.didReceive(response, data: data, error: nil)
        }
        
        // Validate HTTP status
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            // Attempt to decode the error JSON from server
            if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                throw APIClientError.server(message: apiError.message, status: httpResponse.statusCode)
            } else {
                throw APIClientError.unknown
            }
        }
        
        // Decode
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // MARK: - Convenience wrappers
    func getRequest<T: Decodable>(_ endpoint: URLRequest) async throws -> T {
        return try await request(endpoint)
    }
    
    func postRequest<T: Decodable>(_ endpoint: URLRequest) async throws -> T {
        return try await request(endpoint)
    }
    
    func postMultiPartRequest<T: Decodable>(_ endpoint: URLRequest) async throws -> T {
        return try await request(endpoint)
    }
}
