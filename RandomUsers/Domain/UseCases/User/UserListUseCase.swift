//
//  UserListUseCase.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

protocol UserListUseCase {
    func execute(
        requestValue: UserListUseCaseRequestValue,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
}

final class DefaultUserListUseCase: UserListUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(
        requestValue: UserListUseCaseRequestValue,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    ) {
        return userRepository.fetchUserList(
            query: requestValue.query
        ) { response in
                completion(response)
        }
    }
    
}

struct UserListUseCaseRequestValue {
    let query: UserQuery
}
