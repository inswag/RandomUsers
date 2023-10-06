//
//  NewUserListViewModel.swift
//  RandomUsers
//
//  Created by Insu Park on 10/5/23.
//

import Foundation
import Combine

@available(iOS 13.0, *)
final class NewUserListViewModel: ObservableObject {
    
    @Published var items: [UserListItemViewModel] = []
    
    let userListUseCase: UserListUseCase
    var cancellable: Set<AnyCancellable> = []
    
    init(
        userListUseCase: UserListUseCase,
        actions: UserListViewModelActions? = nil
    ) {
        self.userListUseCase = userListUseCase
    }
    
    func fetchList(requestValue: UserListUseCaseRequestValue) {
        userListUseCase.execute(requestValue: requestValue)
            .sink { completion in
                switch completion {
                case .finished:
                    print("call finished")
                case .failure(let failure):
                    print("fail : ", failure)
                }
            } receiveValue: { result in
                switch result {
                case .success(let response):
                    response.results.forEach {
                        let object = $0.toDomain()
                        self.items.append(UserListItemViewModel(user: object))
                    }
                    
                    print("receive Sucess")
                case .failure(let error):
                    print("error: ", error)
                }
            }
            .store(in: &cancellable)
    }
    
}
