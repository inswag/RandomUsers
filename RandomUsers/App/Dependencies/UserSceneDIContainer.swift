//
//  UserSceneDIContainer.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Combine
import SwiftUI
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
    
    // MARK: - Configure View with SwiftUI
    
    func makeNewUserListViewModel() -> NewUserListViewModel {
        NewUserListViewModel(userListUseCase: makeUserListUseCase())
    }
    
    // MARK: - Configure VCs
    
    func makeUserListController(
        with actions: UserListViewModelActions
    ) -> UIViewController {
        
        if #available(iOS 13.0, *) {
            let vc = UserListView(
                viewModel: makeNewUserListViewModel()
            )
            return UIHostingController(rootView: vc)
        } else {
            let vc = UserListViewController()
            vc.viewModel = makeUserListViewModel(actions: actions)
            vc.imageRepository = makeImageRepository()
            return vc
        }
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
        vc.imageRepository = makeImageRepository()
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
            dataTransferService: self.dependencies.apiDataTransferService
        )
    }
    
    func makeImageRepository() -> ImageRepository {
        DefaultImageRepository()
    }

}
