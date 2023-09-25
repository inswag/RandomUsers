//
//  DefaultImageRepository.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/25.
//

import Foundation
import UIKit
import Kingfisher

final class DefaultImageRepository {
    
    init() {
        
    }
    
}

extension DefaultImageRepository: ImageRepository {
    
    func fetchImage(_ imageView: UIView,
                    _ imageURL: String,
                    with placeholder: String) {
        if let iv = imageView as? UIImageView {
            iv.kf.setImage(with: URL.init(string: imageURL),
                           placeholder: UIImage.init(named: placeholder),
                           options: nil,
                           completionHandler: nil)
        }
    }
    
}
