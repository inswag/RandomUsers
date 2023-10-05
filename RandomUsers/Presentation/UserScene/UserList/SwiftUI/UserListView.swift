//
//  UserListView.swift
//  RandomUsers
//
//  Created by Insu Park on 10/4/23.
//

import SwiftUI
import Combine

@available(iOS 13.0, *)
struct UserListView: View {
    
    @ObservedObject var viewModel: NewUserListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                NavigationLink {
    //                UIHosting
                } label: {
                    UserListViewRow(item: item)
                }
            }
        }.onAppear {
            viewModel.fetchList(requestValue: UserListUseCaseRequestValue(query: UserQuery(gender: "male", page: "1")))
        }
    }
    
}

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
