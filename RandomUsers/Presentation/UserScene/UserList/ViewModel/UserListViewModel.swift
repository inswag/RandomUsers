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
    func didSwitchGender()
    func resetPage()
}

protocol UserListViewModelOutput {
    var users: [User] { get }
    var gender: Gender { get }
}

typealias UserListViewModel = UserListViewModelInput & UserListViewModelOutput

enum RequestLoading {
    case fullPage
    case nextPage
}

enum Gender: String {
    case male = "Switch To F"
    case female = "Switch To M"
    
    func getQueryString() -> String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        }
    }
}

typealias CallFinish = (Error?) -> Void

final class DefaultUserListViewModel: UserListViewModel {
    
    // MARK: - Module Interface
    
    private let actions: UserListViewModelActions?
    private let userListUseCase: UserListUseCase
    
    // MARK: - OUTPUT
    
    var users: [User] = []
    var usersUUID: [String] = []
    var gender: Gender = .male
    var page: Int = 1
    
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
        
        if requestLoading == .fullPage {
            self.resetPage()
        }
        
        if requestLoading == .nextPage {
            page += 1
        }
        
        self.userListUseCase.execute(
            requestValue: .init(query: UserQuery.init(gender: self.gender.getQueryString(), page: "\(page)"))
        ) { [weak self] response in
            guard let self = self else { return }
            
            self.isLoading = false

            switch response {
            case .success(let page):
                page.users.forEach {
                    if !self.usersUUID.contains($0.loginInfo.uuid) {
                        self.users.append($0)
                    }
                }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func resetPage() {
        self.page = 1
        self.users.removeAll()
        self.usersUUID.removeAll()
    }
    
}

// MARK: - INPUT

extension DefaultUserListViewModel {
    
    func viewDidLoad() {}
    
    func didLoadPage(completion: @escaping CallFinish) {
        resetPage()
        load(requestLoading: .fullPage, completion: completion)
    }
    
    func didNextPage(completion: @escaping CallFinish) {
        load(requestLoading: .nextPage, completion: completion)
    }
    
    func didSelectUser(at index: Int) {
        actions?.showUserDetail(self.users[index])
    }
    
    func didSwitchGender() {
        if self.gender == .female {
            self.gender = .male
        } else {
            self.gender = .female
        }
    }
    
}
