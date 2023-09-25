//
//  AppDelegate.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.setupInitialRoot()
        return true
    }

}

extension AppDelegate {

    private func setupInitialRoot() {
        let naviCon = UINavigationController()
        naviCon.navigationBar.isHidden = true
        
        self.makeUIWindow()
        self.makeRootViewController(naviCon)
        self.makeAppFlowCoordinator(naviCon,
                                    appDIContainer)
        
        appFlowCoordinator?.startUserScene()
        window?.makeKeyAndVisible()
    }
    
    private func makeUIWindow() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
    }
    
    private func makeRootViewController(
        _ rootVC: UIViewController
    ) {
        self.window?.rootViewController = rootVC
    }
    
    private func makeAppFlowCoordinator(
        _ naviCon: UINavigationController,
        _ appDIContainer: AppDIContainer
    ) {
        self.appFlowCoordinator = AppFlowCoordinator(
            naviCon: naviCon,
            appDIContainer: appDIContainer
        )
    }
    
}
