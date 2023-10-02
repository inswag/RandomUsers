//
//  Service.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation
import Moya
import Combine

enum DefaultNetworkService {
    case userList(form: UserRequestDTO)
}

extension DefaultNetworkService: TargetType {
    
    var baseURL: URL { URL(string: AppConfiguration().apiBaseURL)! }
    
    var path: String {
        switch self {
        case .userList:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .userList(let form):
            return .requestParameters(
                parameters: ["gender": form.gender, "page": form.page, "results": "20"],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

