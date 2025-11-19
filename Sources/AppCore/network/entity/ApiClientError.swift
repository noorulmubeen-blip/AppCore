//
//  ApiClientError.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 19/11/2025.
//

public enum APIClientError: Error {
    case server(message: String, status: Int)
    case unknown
}
