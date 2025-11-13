//
//  getAccessTokenUseCase.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 13/11/2025.
//

class GetAccessTokenUseCase{
    final var preferenceStorage : PreferenceStorage
    
    init(preference: PreferenceStorage){
        self.preferenceStorage = preference
        
    }
    
    func invoke() -> String? {
        var accessToken = preferenceStorage.getAccessToken()
        return accessToken
    }
}
