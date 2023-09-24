//
//  BaseViewController.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit

protocol BaseViewControllerInput {
    func setUpViews()
}

class BaseViewController: UIViewController, BaseViewControllerInput {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        self.view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    
    func showAlert(
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    
}
