//
//  loadingDialog.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 24/09/2025.
//

import SwiftUI

public struct LoadingContainer<T, Content: View, LoadingView: View>: View {
    public let uiState: UiState<T>
    public let content: Content
    public let loadingContent: LoadingView?
    
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder loadingContent: () -> LoadingView?
    ) {
        self.uiState = uiState
        self.content = content()
        self.loadingContent = loadingContent()
    }
    
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content
    ) where LoadingView == EmptyView {
        self.uiState = uiState
        self.content = content()
        self.loadingContent = nil
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            content
        }
        .fullScreenCover(isPresented: .constant(uiState.isLoading)) {
            if(loadingContent == nil){
                LoadingDialog(loadingContent : {ProgressView()}())
            }
            else{
                LoadingDialog(loadingContent: loadingContent)
            }
        }
    }
}


public struct LoadingDialog<ContentView: View>: View {
    public let loadingContent: ContentView
    
    public init(loadingContent: ContentView) {
        self.loadingContent = loadingContent
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            VStack(spacing: 20) {
                loadingContent
            }
        }
    }
}
