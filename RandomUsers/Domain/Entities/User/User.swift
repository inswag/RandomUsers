//
//  User.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

struct UserResponse {
    let users: [User]
}

struct User {
    let gender: String
    let nameInfo: UserName
    let locationInfo: UserLocation
    let picture: UserPicture
    let loginInfo: UserLoginInfo
}

struct UserName {
    let title: String
    let first: String
    let last: String
    
    func makeFullName() -> String {
        return [first, last].joined(separator: " ")
    }
}

struct UserLocation {
    let city: String
    let state: String
    let country: String
    
    func makeLocation() -> String {
        return [city, state, country].joined(separator: ", ")
    }
}

struct UserPicture {
    let largeSize: String
    let mediumSize: String
    let thumbnail: String
}

struct UserLoginInfo {
    let uuid: String
    let username: String
    let password: String
}
