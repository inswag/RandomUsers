//
//  Service+Transfer.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Combine
import Foundation

import CombineMoya
import Moya

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
}

protocol DataTransferService {
    typealias CompletionHandle = (Result<UserResponseDTO, DataTransferError>) -> Void
    
    func request(
        target: DefaultNetworkService,
        completion: @escaping (Result<UserResponseDTO, DataTransferError>) -> Void
    )
    
    func request(
        target: DefaultNetworkService
    ) -> AnyPublisher<Response, Error>
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

final class DefaultTransferService: DataTransferService {

    private let provider: MoyaProvider<DefaultNetworkService>

    init(provider: MoyaProvider<DefaultNetworkService>) {
        self.provider = provider
    }
    
}

extension DefaultTransferService {
    
    // MARK: - Combine Moya
    
    func request(target: DefaultNetworkService) -> AnyPublisher<Response, Error> {
        provider.requestPublisher(target)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Original Moya
    
    func request(
        target: DefaultNetworkService,
        completion: @escaping (Result<UserResponseDTO, DataTransferError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                let result = self.decode(data: response.data)
                completion(result)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    private func decode(
        data: Data?
    ) -> Result<UserResponseDTO, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result = try JSONDecoder().decode(UserResponseDTO.self, from: data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
    
}
