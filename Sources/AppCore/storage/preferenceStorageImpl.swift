//
//  preferenceStorageImpl.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 12/11/2025.
//
import Foundation

class PreferenceStorageImpl: PreferenceStorage {
    
    private let defaults: UserDefaults
    final var ACCESS_TOKEN_KEY  = "access token"
    final var REFRESH_TOKEN_KEY  = "refresh token"
    
    // Dependency Injection for unit tests
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func set<T>(_ value: T, forKey key: String) where T : Decodable, T : Encodable {
        self.defaults.set(value, forKey: key)
    }
    
    func get<T>(_ type: T.Type, forKey key: String) throws -> T? where T : Decodable, T : Encodable {
        if let value = defaults.object(forKey: key) as? T {
            return value
        }
        return nil
    }
    
    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    func getAccessToken() -> String?{
        if let value = defaults.string(forKey: ACCESS_TOKEN_KEY) as? String {
            return value
        }
        return nil
    }
    
    func setAccessToken(_ token: String){
        self.defaults.set(token, forKey: ACCESS_TOKEN_KEY)
    }
    
    func removeAccessToken(){
        self.defaults.removeObject(forKey: ACCESS_TOKEN_KEY)
    }
    
    func removeRefreshToken(){
        self.defaults.removeObject(forKey: REFRESH_TOKEN_KEY)
    }
    
    func getRefreshToken() -> String? {
        if let value = defaults.string(forKey: REFRESH_TOKEN_KEY) as? String {
            return value
        }
        return nil
    }
    
    func setRefreshToken(_ token: String){
        self.defaults.set(token, forKey: REFRESH_TOKEN_KEY)
    }
}
