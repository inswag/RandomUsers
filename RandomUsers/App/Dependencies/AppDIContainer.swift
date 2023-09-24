//
//  AppDIContainer.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
//    lazy var apiDataTransferService: DataTransferService = {
//        return DefaultTransferService(provider: MoyaProvider<DefaultNetworkService>(plugins: [RequestLoggingPlugin()]))
//    }()
    
    // MARK: - DIContainers of Scenes
  
    func makeUserSceneDIContainer() -> UserSceneDIContainer {
//        let dependencies = UserSceneDIContainer.Dependencies(
//            apiDataTransferService: self.apiDataTransferService
//        )
//
//        return UserSceneDIContainer(dependencies: dependencies)
        
        return UserSceneDIContainer()
    }
    
}
