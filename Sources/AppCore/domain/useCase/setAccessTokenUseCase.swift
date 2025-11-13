//
//  setAccessTokenUseCase.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 13/11/2025.
//

class SetAccessTokenUseCase{
    final var preferenceStorage : PreferenceStorage
    
    init(preference: PreferenceStorage){
        self.preferenceStorage = preference
        
    }
    
    func invoke(token: String) {
        preferenceStorage.setAccessToken(token)
    }
}
