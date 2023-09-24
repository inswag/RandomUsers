//
//  AppConfiguration.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

final class AppConfiguration {
    
    lazy var apiBaseURL: String = {
        return "https://randomuser.me/api/"
    }()
    
}
