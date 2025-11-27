//
//  TextEditorForState.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 26/11/2025.
//
import SwiftUI
import AppCore

public struct TextEditorForState : View {
    var placeholder: String = "Enter Text Here..."
    let uiState: UiState<String>
    let onUpdate: (String) -> Void
    
    @State private var text: String
    
    public init(uiState: UiState<String>, onUpdate: @escaping (String) -> Void, placeHolder: String? = nil) {
        self.uiState = uiState
        self.onUpdate = onUpdate
        self.placeholder = placeHolder ?? "Enter Text Here..."
        self._text = State(initialValue: uiState.data ?? "")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $text)
                .textFieldStyle(.roundedBorder)
                .onChange(of: text) { newValue in
                    self.onUpdate(newValue)
                }
            
            if case .uiError(let message, _, _, _) = self.uiState {
                Text(message).foregroundColor(.red)
            }
        }
        .onChange(of: uiState.data) { newData in
            if let newData = newData {
                if text != newData {
                    self.text = newData
                }
            } else {
                self.text = ""
            }
        }
    }
}
