// The Swift Programming Language
// https://docs.swift.org/swift-book
import Swinject

public final class AppCoreAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {

        // MARK: - Local Storage
        container.register(PreferenceStorage.self) { _ in
            PreferenceStorageImpl()
        }
        .inObjectScope(.container)

        // MARK: - Use Cases
        container.register(GetAccessTokenUseCase.self) { r in
            GetAccessTokenUseCase(preference: r.resolve(PreferenceStorage.self)!)
        }

        container.register(SetAccessTokenUseCase.self) { r in
            SetAccessTokenUseCase(preference: r.resolve(PreferenceStorage.self)!)
        }

        // MARK: - Interceptors
        container.register(AuthInterceptor.self) { r in
            AuthInterceptor(preference: r.resolve(PreferenceStorage.self)!)
        }
        .inObjectScope(.transient)

        container.register(LogInterceptor.self) { _ in
            LogInterceptor()
        }
        .inObjectScope(.transient)

        // MARK: - API Client
        container.register(APIClient.self) { r in
            let auth = r.resolve(AuthInterceptor.self)!
            let log  = r.resolve(LogInterceptor.self)!
            return DefaultAPIClient(interceptors: [auth, log])
        }
        .inObjectScope(.container)
    }
}
