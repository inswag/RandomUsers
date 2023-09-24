//
//  UserDetailViewModel.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

protocol UserDetailViewModelInput {
    
}

protocol UserDetailViewModelOutput {
    var user: User { get set }
}

typealias UserDetailViewModel = UserDetailViewModelInput & UserDetailViewModelOutput

final class DefaultUserDetailViewModel: UserDetailViewModel {
    
    // MARK: - Output
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
}
