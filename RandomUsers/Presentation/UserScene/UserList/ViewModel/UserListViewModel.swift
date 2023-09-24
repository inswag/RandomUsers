//
//  UserListViewModel.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

struct UserListViewModelActions {
    let showUserDetail: (User) -> Void
}

protocol UserListViewModelInput {
    func viewDidLoad()
    func didLoadPage(completion: @escaping CallFinish)
    func didNextPage(completion: @escaping CallFinish)
    func didSelectUser(at index: Int)
}

protocol UserListViewModelOutput {
    var items: [UserListItemViewModel] { get }
    var offset: Int { get }
    var users: [User] { get }
}

typealias UserListViewModel = UserListViewModelInput & UserListViewModelOutput

enum RequestLoading {
    case fullPage
    case nextPage
}

typealias CallFinish = (Error?) -> Void

final class DefaultUserListViewModel: UserListViewModel {
    
    // MARK: - Module Interface
    
    private let actions: UserListViewModelActions?
    private let userListUseCase: UserListUseCase
    
    // MARK: - OUTPUT
    
    var users: [User] = []
    var items: [UserListItemViewModel] = []
    var offset: Int = 0
    
    // API CALL
    var isLoading: Bool = false
    var requestLoading: RequestLoading = .fullPage
    
    // MARK: Initializer
    
    init(
        userListUseCase: UserListUseCase,
        actions: UserListViewModelActions? = nil
    ) {
        self.userListUseCase = userListUseCase
        self.actions = actions
    }
    
    // MARK: Load
    
    func load(
        requestLoading: RequestLoading,
        completion: @escaping CallFinish
    ) {
        guard !isLoading else { return }
        self.isLoading = true
        
        if requestLoading == .nextPage {
            offset += 20
        }
        
//        self.userListUseCase.execute(
//            requestValue: .init(query: .init(offset: "\(offset)"))
//        ) { [weak self] response in
//
//            self?.isLoading = false
//
//            switch response {
//            case .success(let page):
//                page.data.users.forEach {
//                    self?.users.append($0)
//                }
//                completion(nil)
//            case .failure(let error):
//                completion(error)
//            }
//        }
    }
    
}

// MARK: - INPUT

extension DefaultUserListViewModel {
    
    func viewDidLoad() {}
    
    func didLoadPage(completion: @escaping CallFinish) {
        load(requestLoading: .fullPage, completion: completion)
    }
    
    func didNextPage(completion: @escaping CallFinish) {
        load(requestLoading: .nextPage, completion: completion)
    }
    
    func didSelectUser(at index: Int) {
        actions?.showUserDetail(self.users[index])
    }
    
}
