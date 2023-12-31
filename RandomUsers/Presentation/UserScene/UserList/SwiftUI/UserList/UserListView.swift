//
//  UserListView.swift
//  RandomUsers
//
//  Created by Insu Park on 10/4/23.
//

import SwiftUI
import Combine

@available(iOS 14.0, *)
struct UserListView: View {
    
    @ObservedObject var viewModel: NewUserListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        UserDetailView(item: item)
                    } label: {
                        UserListViewRow(item: item)
                    }
                }
            }.onAppear {
                viewModel.fetchList(requestValue: UserListUseCaseRequestValue(query: UserQuery(gender: "male", page: "1")))
            }
            .navigationTitle("RandomUsers")
            .listStyle(.plain)
        }
    }
    
}

