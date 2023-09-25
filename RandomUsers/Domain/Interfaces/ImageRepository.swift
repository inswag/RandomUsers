//
//  ImageRepository.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/25.
//

import UIKit

protocol ImageRepository {
    func fetchImage(_ imageView: UIView,
                    _ imageURL: String,
                    with placeholder: String)
}
