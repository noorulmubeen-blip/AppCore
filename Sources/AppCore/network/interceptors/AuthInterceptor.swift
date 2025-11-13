//
//  LogInterceptor 2.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 13/11/2025.
//


import Foundation

final class AuthInterceptor: RequestInterceptor {
    private let preferenceStorage: PreferenceStorage
    
    init(preference: PreferenceStorage) {
        self.preferenceStorage = preference
    }
    
    func adapt(_ request: URLRequest) async throws -> URLRequest {
        var newRequest = request
        
        let token = preferenceStorage.getAccessToken()
        if let token = token, !token.isEmpty {
            newRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return newRequest
    }
    
    func willSend(_ request: URLRequest) {
        // Optional: Log that auth header was added
    }
    
    func didReceive(_ response: URLResponse, data: Data?, error: Error?) {
        // Optional: Handle token refresh on 401, etc.
    }
}
