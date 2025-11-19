//
//  preferenceStorage.swift
//  AppCore
//
//  Created by Noor ul Mubeen on 12/11/2025.
//

public protocol PreferenceStorage {
    func set<T: Codable>(_ value: T, forKey key: String)
    func get<T: Codable>(_ type: T.Type, forKey key: String) throws -> T?
    func setAccessToken(_ accessToken: String)
    func getAccessToken() -> String?
    func removeAccessToken()
    func getRefreshToken() -> String?
    func setRefreshToken(_ refreshToken: String)
    func removeRefreshToken()
    func remove(forKey key: String)
}
