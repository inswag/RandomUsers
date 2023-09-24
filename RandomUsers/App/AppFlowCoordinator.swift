//
//  AppFlowCoordinator.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit

final class AppFlowCoordinator {
    
    var naviCon: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        naviCon: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.naviCon = naviCon
        self.appDIContainer = appDIContainer
    }
    
    func startUserScene() {
        let userDIContainer = appDIContainer.makeUserSceneDIContainer()
        let flow = userDIContainer.makeUserSceneFlowCoordinator(naviCon: self.naviCon)
        flow.start()
    }
    
}
