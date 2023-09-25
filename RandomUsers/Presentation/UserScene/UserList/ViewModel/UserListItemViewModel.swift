//
//  UserListItemViewModel.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

struct UserListItemViewModel {
    let thumbnail: String
    let username: String
    let addressInfo: String
}

extension UserListItemViewModel {
    
    init(user: User) {
        thumbnail = user.picture.thumbnail
        username = user.nameInfo.makeFullName()
        addressInfo = user.locationInfo.makeLocation()
    }
    
}

