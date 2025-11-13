//
//  LogInterceptor.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 13/11/2025.
//
import Foundation


final class LogInterceptor: RequestInterceptor {
    
    func adapt(_ request: URLRequest) async throws -> URLRequest {
        // No modification needed for logging
        return request
    }
    
    func willSend(_ request: URLRequest) {
        logRequest(request)
    }
    
    func didReceive(_ response: URLResponse, data: Data?, error: Error?) {
        if let error = error {
            logError(error)
            return
        }
        
        logResponse(response, data: data)
    }
    
    // MARK: - Private Logging Methods
    private func logRequest(_ request: URLRequest) {
        print("\n🚀 ===== NETWORK REQUEST =====")
        print("📍 URL: \(request.url?.absoluteString ?? "N/A")")
        print("🔧 Method: \(request.httpMethod ?? "N/A")")
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("📋 Headers:")
            headers.forEach { key, value in
                print("   \(key): \(value)")
            }
        }
        
        if let body = request.httpBody {
            if let jsonObject = try? JSONSerialization.jsonObject(with: body, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("📦 Body (JSON):")
                print(prettyString)
            } else if let bodyString = String(data: body, encoding: .utf8) {
                print("📦 Body:")
                print(bodyString)
            }
        }
        
        print("=============================\n")
    }
    
    private func logResponse(_ response: URLResponse, data: Data?) {
        print("\n✅ ===== NETWORK RESPONSE =====")
        
        if let httpResponse = response as? HTTPURLResponse {
            print("📍 URL: \(httpResponse.url?.absoluteString ?? "N/A")")
            print("📊 Status Code: \(httpResponse.statusCode)")
            
            if !httpResponse.allHeaderFields.isEmpty {
                print("📋 Headers:")
                httpResponse.allHeaderFields.forEach { key, value in
                    print("   \(key): \(value)")
                }
            }
        }
        
        if let data = data, !data.isEmpty {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("📦 Response (JSON):")
                print(prettyString)
            } else if let responseString = String(data: data, encoding: .utf8) {
                print("📦 Response:")
                print(responseString)
            } else {
                print("📦 Response Data Size: \(data.count) bytes")
            }
        }
        
        print("==============================\n")
    }
    
    private func logError(_ error: Error) {
        print("\n❌ ===== NETWORK ERROR =====")
        print("Error: \(error.localizedDescription)")
        print("===========================\n")
    }
}
