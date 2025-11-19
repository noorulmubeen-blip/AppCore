//
//  networkResponse.swift
//
//
//  Created by Noor ul Mubeen on 22/09/2025.
//
public enum NetworkResponse<T>{
    case success(data: T)
    case error(message: String, code:Int? = nil, data : T? = nil)
    case exception(Error)
}


public extension NetworkResponse {
    public func toDomainResponse() -> DomainResponse<T> {
        switch self {
        case .success(let data):
            return .Success(data : data)
            
        case .error(let message, _, let data):
            return .Error(data: data, message: message)
            
        case .exception(let error):
            return .Error(data: nil, message: error.localizedDescription)
        }
    }
}
