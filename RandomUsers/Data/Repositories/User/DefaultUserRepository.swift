//
//  DefaultUserRepository.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

final class DefaultUserRepository {

    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
}

extension DefaultUserRepository: UserRepository {

    func fetchUserList(
        query: UserQuery,
        completion: @escaping (Result<UserResponse, Error>) -> Void
    ) {
        let requestDTO = UserRequestDTO(
            gender: query.gender,
            page: query.page
        )
        
//        dataTransferService.request(target: .userList(form: requestDTO)) { result in
//            switch result {
//            case .success(let response):
//                completion(.success(response.toDomain()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
}
