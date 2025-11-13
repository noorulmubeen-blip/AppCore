//
//  requestInterceptor.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 13/11/2025.
//


import Foundation

protocol RequestInterceptor {
    func adapt(_ request: URLRequest) async throws -> URLRequest
    func willSend(_ request: URLRequest)
    func didReceive(_ response: URLResponse, data: Data?, error: Error?)
}
