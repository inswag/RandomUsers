//
//  UserItemCell.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit
import Kingfisher

class UserItemCell: UITableViewCell {

    static let identifier = String(describing: UserItemCell.self)
    
    // MARK: - UI Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressInfoLabel: UILabel!
    
    // MARK: - Properties
    
    private var viewModel: UserListItemViewModel!
    private var imageRepository: ImageRepository!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Fill
    
    func fill(
        with viewModel: UserListItemViewModel,
        imageRepository: ImageRepository
    ) {
        self.viewModel = viewModel
        
        self.usernameLabel.text = viewModel.username
        self.addressInfoLabel.text = viewModel.addressInfo
        
        imageRepository.fetchImage(
            self.profileImageView,
            viewModel.thumbnail,
            with: "no_image"
        )
    }
    
}
