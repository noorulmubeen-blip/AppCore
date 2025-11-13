//
//  uiState.swift
//
//
//  Created by Noor ul Mubeen on 22/09/2025.
//

public enum UiState<T> {
    case uiIdle(data: T?)
    case uiLoading(data: T?)
    case uiSuccess(data: T)
    case uiError(message: String, errorException: Error? = nil, code: Int? = nil, data: T?)
}

public extension UiState {
    var isLoading: Bool {
        if case .uiLoading = self {
            return true
        }
        return false
    }
    var data: T? {
        switch self {
        case .uiIdle(let data),
                .uiLoading(let data),
                .uiError(_, _, _, let data):
            return data
        case .uiSuccess(let data):
            return data 
        }
    }
}
