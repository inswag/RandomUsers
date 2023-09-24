//
//  UserSceneDIContainer.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit

final class UserSceneDIContainer: UserFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: Flow Coordinators

    func makeUserSceneFlowCoordinator(
        naviCon: UINavigationController
    ) -> UserFlowCoordinator {
        UserFlowCoordinator(
            naviCon: naviCon,
            dependencies: self
        )
    }
    
    // MARK: - Configure VCs
    
    func makeUserListController(
        with actions: UserListViewModelActions
    ) -> UserListViewController {
        let vc = UserListViewController()
        vc.viewModel = makeUserListViewModel(actions: actions)
        return vc
    }
    
    func makeUserListViewModel(
        actions: UserListViewModelActions
    ) -> UserListViewModel {
        DefaultUserListViewModel(
            userListUseCase: makeUserListUseCase(),
            actions: actions
        )
    }
    
    func makeUserListUseCase() -> UserListUseCase {
        DefaultUserListUseCase.init(
            userRepository: makeUserRepository()
        )
    }
    
    func makeUserDetailController(
        user: User
    ) -> UserDetailViewController {
        let vc = UserDetailViewController()
        vc.viewModel = self.makeUserDetailViewModel(user: user)
        return vc
    }
    
    func makeUserDetailViewModel(user: User) -> UserDetailViewModel {
        DefaultUserDetailViewModel(
            user: user
        )
    }
    
    // MARK: - Repositories
    
    func makeUserRepository() -> UserRepository {
        DefaultUserRepository(
            dataTransferService: <#T##DataTransferService#>
        )
    }

}
