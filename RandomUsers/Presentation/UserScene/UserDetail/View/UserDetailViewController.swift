//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit
import Kingfisher

class UserDetailViewController: BaseViewController {

    // MARK: - UI Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressInfoLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: UserDetailViewModel!
    var imageRepository: ImageRepository!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        self.usernameLabel
            .text = viewModel.user.nameInfo.makeFullName()
        self.addressInfoLabel.text = viewModel.user.locationInfo.makeLocation()
        imageRepository.fetchImage(
            self.profileImageView,
            viewModel.user.picture.largeSize,
            with: "no_image"
        )
    }

    // MARK: - Event Methods
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
