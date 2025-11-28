//
//  fullScreenDialog.swift
//
//
//  Created by Noor ul Mubeen on 22/09/2025.
//

import SwiftUI

public struct FullScreenContainer<T, Content: View, DialogView: View>: View {
    public let uiState: UiState<T>
    public let content: Content
    public let dialogContent: DialogView?
    
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder dialogContent: () -> DialogView?
    ) {
        self.uiState = uiState
        self.content = content()
        self.dialogContent = dialogContent()
    }
    
    
    public init(
        uiState: UiState<T>,
        @ViewBuilder content: () -> Content
    ) where DialogView == EmptyView {
        self.uiState = uiState
        self.content = content()
        self.dialogContent = nil
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            content
        }
        .fullScreenCover(isPresented: .constant(uiState.isLoading)) {
            if let dialogContent{
                FullScreenDialog(dialogContent: dialogContent)
            }
        }
    }
}

public struct FullScreenDialog<ContentView: View>: View {
    public let dialogContent: ContentView
    
    public init(dialogContent: ContentView) {
        self.dialogContent = dialogContent
    }
    
    public var body: some View {
        ZStack {
            Color.white.opacity(0.05).ignoresSafeArea()
            
            VStack(spacing: 20) {
                dialogContent
                
            }
        }
    }
}
