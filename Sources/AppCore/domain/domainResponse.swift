//
//  domainResponse.swift
//  
//
//  Created by Noor ul Mubeen on 22/09/2025.

public enum DomainResponse<T> {
    case Success(data: T)
    case Error(data: T?, message: String)
}
