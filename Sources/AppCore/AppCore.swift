// The Swift Programming Language
// https://docs.swift.org/swift-book
import Swinject

public class AppCoreAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(PreferenceStorage.self) { _ in
            PreferenceStorageImpl()
        }
        container.register(GetAccessTokenUseCase.self) { resolver in
            let preferenceStorage = resolver.resolve(PreferenceStorage.self)!
            return GetAccessTokenUseCase(preference : preferenceStorage)
        }
        container.register(SetAccessTokenUseCase.self) { resolver in
            let preferenceStorage = resolver.resolve(PreferenceStorage.self)!
            return SetAccessTokenUseCase(preference : preferenceStorage)
        }
        container.register(AuthInterceptor.self) { resolver in
            let preferenceStorage = resolver.resolve(PreferenceStorage.self)!
            return AuthInterceptor(preference: preferenceStorage)
        }
        container.register(LogInterceptor.self) { _ in
            return LogInterceptor()
        }
        container.register(APIClient.self) { resolver in
            let authInterceptor = resolver.resolve(AuthInterceptor.self)!
            let logInterceptor = resolver.resolve(LogInterceptor.self)!
            return DefaultAPIClient(interceptors: [authInterceptor, logInterceptor])
        }
    }
}
