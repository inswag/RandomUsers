//
//  UserResponseDTO+Mapping.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import Foundation

struct UserResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    var results: [UserDTO]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = (try? values.decode([UserDTO].self, forKey: .results)) ?? []
    }
}

extension UserResponseDTO {
    struct UserDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case gender, name, picture, login, location
        }
        
        let gender: String
        let name: NameDTO?
        let location: LocationDTO?
        let picture: PictureDTO?
        let login: LoginDTO?
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            self.gender = (try? values.decode(String.self, forKey: .gender)) ?? ""
            self.name = (try? values.decode(NameDTO.self, forKey: .name)) ?? nil
            self.location = (try? values.decode(LocationDTO.self, forKey: .location)) ?? nil
            self.picture = (try? values.decode(PictureDTO.self, forKey: .picture)) ?? nil
            self.login = (try? values.decode(LoginDTO.self, forKey: .login)) ?? nil
        }
    }
}

extension UserResponseDTO {
    
    struct NameDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case title, first, last
        }
        
        let title: String
        let first: String
        let last: String
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.title = (try? values.decode(String.self, forKey: .title)) ?? ""
            self.first = (try? values.decode(String.self, forKey: .first)) ?? ""
            self.last = (try? values.decode(String.self, forKey: .last)) ?? ""
        }
    }
    
    struct LocationDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case city, state, country
        }
        
        let city: String
        let state: String
        let country: String
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.city = (try? values.decode(String.self, forKey: .city)) ?? ""
            self.state = (try? values.decode(String.self, forKey: .state)) ?? ""
            self.country = (try? values.decode(String.self, forKey: .country)) ?? ""
        }
    }
    
    struct LoginDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case uuid, username, password
        }
        
        let uuid: String
        let username: String
        let password: String
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.uuid = (try? values.decode(String.self, forKey: .uuid)) ?? ""
            self.username = (try? values.decode(String.self, forKey: .username)) ?? ""
            self.password = (try? values.decode(String.self, forKey: .password)) ?? ""
        }
    }
    
    struct PictureDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case medium, large, thumbnail
        }
        
        let medium: String
        let large: String
        let thumbnail: String
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.medium = (try? values.decode(String.self, forKey: .medium)) ?? ""
            self.large = (try? values.decode(String.self, forKey: .large)) ?? ""
            self.thumbnail = (try? values.decode(String.self, forKey: .thumbnail)) ?? ""
        }
    }
}

// MARK: - Make toDomain()

extension UserResponseDTO {
    func toDomain() -> UserResponse {
        UserResponse(users: self.results.map { $0.toDomain() })
    }
}

extension UserResponseDTO.UserDTO {
    func toDomain() -> User {
        return User(
            gender: self.gender,
            nameInfo: self.name?.toDomain() ?? UserName(title: "", first: "", last: ""),
            locationInfo: self.location?.toDomain() ?? UserLocation(city: "", state: "", country: ""),
            picture: self.picture?.toDomain() ?? UserPicture(largeSize: "", mediumSize: "", thumbnail: ""),
            loginInfo: self.login?.toDomain() ?? UserLoginInfo(uuid: "", username: "", password: "")
        )
    }
}

extension UserResponseDTO.NameDTO {
    func toDomain() -> UserName {
        UserName.init(
            title: self.title,
            first: self.first,
            last: self.last
        )
    }
}

extension UserResponseDTO.LocationDTO {
    func toDomain() -> UserLocation {
        UserLocation.init(
            city: self.city,
            state: self.state,
            country: self.country
        )
    }
}

extension UserResponseDTO.PictureDTO {
    func toDomain() -> UserPicture {
        UserPicture(
            largeSize: self.large,
            mediumSize: self.medium,
            thumbnail: self.thumbnail
        )
    }
}

extension UserResponseDTO.LoginDTO {
    func toDomain() -> UserLoginInfo {
        UserLoginInfo(
            uuid: self.uuid,
            username: self.username,
            password: self.password
        )
    }
}

