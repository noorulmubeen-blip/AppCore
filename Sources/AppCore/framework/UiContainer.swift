//
//  UiContainer.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 27/11/2025.
//
import SwiftUI
import Combine


public struct UiContainer<
    T,
    Content: View,
    LoadingView: View,
    ErrorView: View
>: View {
    
    public let uiState: UiState<T>
    public let content: Content
    public let loadingContent: LoadingView?
    public let errorContent: ErrorView?
    
    @State private var showLoading = false
    @State private var activeError: ErrorData? = nil
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder loadingContent: () -> LoadingView? = { nil },
        @ViewBuilder errorContent: () -> ErrorView? = { nil }
    ) {
        self.uiState = uiState
        self.content = content()
        self.loadingContent = loadingContent()
        self.errorContent = errorContent()
    }
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder errorContent: () -> ErrorView? = { nil }
    ) where LoadingView == EmptyView {
        self.uiState = uiState
        self.content = content()
        self.loadingContent = nil
        self.errorContent = errorContent()
    }
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content
    ) where LoadingView == EmptyView, ErrorView == EmptyView {
        self.uiState = uiState
        self.content = content()
        self.loadingContent = nil
        self.errorContent = nil
    }
    
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder loadingContent: () -> LoadingView? = { nil }
    ) where ErrorView == EmptyView {
        self.uiState = uiState
        self.content = content()
        self.loadingContent = loadingContent()
        self.errorContent = nil
    }
    
    
    public var body: some View {
        VStack {
            content
        }
        .onReceive(Just(uiState)) { newValue in
            switch newValue {
            case .uiLoading:
                showLoading = true
                activeError = nil   // dismiss error if showing
                
            case .uiError(let message, _, _, _):
                activeError = ErrorData(message: message)
                showLoading = false  // dismiss loading if showing
                
            default: // uiIdle or uiSuccess
                showLoading = false
                activeError = nil
            }
        }
        .fullScreenCover(isPresented: $showLoading) {
            if let customLoading = loadingContent {
                LoadingDialog(loadingContent: customLoading)
            } else {
                LoadingDialog(loadingContent: ProgressView())
            }
        }
        .fullScreenCover(item: $activeError) { errorData in
            // errorData is guaranteed to contain the message here
            if let customError = errorContent {
                ErrorDialog(errorContent: customError) // You may need to pass the message to customError
            } else {
                DefaultErrorDialog(
                    // Use the message GUARANTEED to be here
                    message: errorData.message,
                    onDismiss: { activeError = nil }
                )
            }
        }
    }
}
