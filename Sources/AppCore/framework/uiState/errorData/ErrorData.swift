//
//  ErrorData.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 28/11/2025.
//
import Foundation

struct ErrorData: Identifiable, Equatable {
    // 1. The required 'id' property
    let id: UUID = UUID()
    
    // 2. The data payload
    let message: String
}
