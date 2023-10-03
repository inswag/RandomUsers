//
//  UserRepository.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation
import Combine

protocol UserRepository {
    func fetchUserList(
        query: UserQuery,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
    
    // MARK: - Combine
    
    func fetchUserList(
        query: UserQuery
    ) ->  AnyPublisher<Result<UserResponseDTO, DataTransferError>, Error>
}
