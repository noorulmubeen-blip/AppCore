//
//  errorDialog.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 27/11/2025.
//

import SwiftUI
import Combine

public struct ErrorContainer<T, Content: View, ErrorView: View>: View {
    
    public let uiState: UiState<T>
    public let content: Content
    public let errorContent: ErrorView?
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder errorContent: () -> ErrorView?
    ) {
        self.uiState = uiState
        self.content = content()
        self.errorContent = errorContent()
    }
    
    // version without custom errorView
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content
    ) where ErrorView == EmptyView {
        self.uiState = uiState
        self.content = content()
        self.errorContent = nil
    }
    
    public var body: some View {
        VStack {
            content
        }
        .onReceive(Just(uiState)) { newValue in
            switch newValue {
            case .uiError(let message, _, _, _):
                self.errorMessage = message
                self.showError = true
            default:
                break
            }
        }
        .fullScreenCover(isPresented: $showError) {
            if let providedErrorView = errorContent {
                ErrorDialog(errorContent: providedErrorView)
            } else {
                DefaultErrorDialog(
                    message: errorMessage,
                    onDismiss: { showError = false }
                )
            }
        }
    }
}


public struct ErrorDialog<ContentView: View>: View {
    public let errorContent: ContentView
    
    public init(errorContent: ContentView) {
        self.errorContent = errorContent
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack {
                errorContent
            }
            .padding()
        }
    }
}

public struct DefaultErrorDialog: View {
    let message: String
    let onDismiss: () -> Void
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Error")
                    .font(.headline)
                
                Text(message)
                    .multilineTextAlignment(.center)
                
                Button("OK") {
                    onDismiss()
                }
                .padding(.top, 8)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(radius: 10)
            .padding(40)
        }.onAppear(){
            print(message)
        }
    }
}
