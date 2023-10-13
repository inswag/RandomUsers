//
//  UserFlowCoordinator.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit

protocol UserFlowCoordinatorDependencies {
    func makeUserListController(
        with actions: UserListViewModelActions
    ) -> UIViewController
    func makeUserDetailController(
        user: User
    ) -> UserDetailViewController
}

final class UserFlowCoordinator {
    
    private weak var naviCon: UINavigationController?
    private let dependencies: UserFlowCoordinatorDependencies
    
    private weak var userListVC: UIViewController?
    private weak var userDetailVC: UserDetailViewController?
    
    init(
        naviCon: UINavigationController? = nil,
        dependencies: UserFlowCoordinatorDependencies
    ) {
        self.naviCon = naviCon
        self.dependencies = dependencies
    }
    
    // MARK: - Start
    
    func start() {
        let actions = UserListViewModelActions(
            showUserDetail: self.showUserDetail
        )
        
        let vc = dependencies.makeUserListController(with: actions)
        naviCon?.pushViewController(vc, animated: false)
        userListVC = vc
    }
    
    // MARK: - Actions
    
    func showUserDetail(user: User) {
        let vc = dependencies.makeUserDetailController(user: user)
        naviCon?.pushViewController(vc, animated: true)
        userDetailVC = vc
    }
    
}
