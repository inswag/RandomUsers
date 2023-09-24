//
//  UserRepository.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

protocol UserRepository {
    func fetchUserList(
        query: UserQuery,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    )
}
