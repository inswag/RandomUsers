//
//  UserListUseCase.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation
import Combine

protocol UserListUseCase {
    func execute(
        requestValue: UserListUseCaseRequestValue,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
    
    func execute(
        requestValue: UserListUseCaseRequestValue
    ) -> AnyPublisher<Result<UserResponseDTO, DataTransferError>, Error>
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
    
    // MARK: - Combine
    
    func execute(
        requestValue: UserListUseCaseRequestValue
    ) -> AnyPublisher<Result<UserResponseDTO, DataTransferError>, Error> {
        return userRepository
            .fetchUserList(query: requestValue.query)
    }
    
}

struct UserListUseCaseRequestValue {
    let query: UserQuery
}
