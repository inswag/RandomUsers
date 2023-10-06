//
//  UserDetailView.swift
//  RandomUsers
//
//  Created by Insu Park on 10/5/23.
//

import SwiftUI

struct UserDetailView: View {
    
    var item: UserListItemViewModel
    
    var body: some View {
        Image("no_image")
            .resizable()
            .frame(width: 180, height: 180)
        VStack {
            Text(item.username)
            Text(item.addressInfo)
        }
    }
}
