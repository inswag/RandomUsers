//
//  DefaultUserRepository.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation
import Combine

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
        
        dataTransferService.request(target: .userList(form: requestDTO)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Combine
    
    func fetchUserList(
        query: UserQuery) ->  AnyPublisher<Result<UserResponseDTO, DataTransferError>, Error>
    {
        let requestDTO = UserRequestDTO(
            gender: query.gender,
            page: query.page
        )
  
        return dataTransferService
            .request(target: .userList(form: requestDTO))

        
//        dataTransferService
//            .request(target: .userList(form: requestDTO))
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("User List Request Finished")
//                case .failure(let error):
//                    print("User List Request Fail : ", error)
//                }
//            } receiveValue: { response in
//                
//                
//                response.data
//            }

        
    }
    
}
