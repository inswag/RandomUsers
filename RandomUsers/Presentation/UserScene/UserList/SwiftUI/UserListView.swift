//
//  UserListView.swift
//  RandomUsers
//
//  Created by Insu Park on 10/4/23.
//

import SwiftUI

@available(iOS 13.0, *)
struct UserListView: View {
    
    @ObservedObject var viewModelWrapper: UserListViewModelWrapper
    
    var body: some View {
        List {
            ForEach(viewModelWrapper.items) { item in
                NavigationLink {
    //                UIHosting
                } label: {
                    UserListViewRow(item: item)
                }
            }
        }.onAppear {
            viewModelWrapper.viewModel?.didLoadPage(completion: <#T##CallFinish##CallFinish##(Error?) -> Void#>)
        }
    }
    
}

@available(iOS 13.0, *)
final class UserListViewModelWrapper: ObservableObject {
    
    var viewModel: UserListViewModel?
    
    @Published var items: [UserListItemViewModel] = []
    
    init(viewModel: UserListViewModel?) {
        self.viewModel = viewModel
    }
    
    
    
}
