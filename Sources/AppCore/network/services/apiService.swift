//
//  api_service.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 24/09/2025.
//
import Foundation

public protocol APIClient {
    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T
    func getRequest<T: Decodable>(_ endpoint: URLRequest) async throws -> T
    func postRequest<T: Decodable>(_ endpoint: URLRequest) async throws -> T
    func postMultiPartRequest<T: Decodable>(_ endpoint: URLRequest) async throws -> T
}
