//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Insu Park on 2023/09/24.
//

import UIKit

class UserListViewController: BaseViewController {

    // MARK: - UI Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchButton: UIButton!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties
    
    var viewModel: UserListViewModel!
    var imageRepository: ImageRepository!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.load(category: .fullPage)
    }
    
    // MARK: - UI Configure

    override func setUpViews() {
        super.setUpViews()
        self.tableView.register(
            UINib.init(nibName: UserItemCell.identifier,
                       bundle: nil),
            forCellReuseIdentifier: UserItemCell.identifier
        )
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.switchButton
            .setTitle(viewModel.gender.rawValue,
                      for: .normal)
        self.tableView.refreshControl = refreshControl
        self.tableView.refreshControl?
            .addTarget(self,
                       action: #selector(pullToRefresh),
                       for: .valueChanged)
    }
    
    // MARK: Event Methods
    
    @IBAction func switchGender(_ sender: UIButton) {
        viewModel.didSwitchGender()
        viewModel.resetPage()
        self.tableView.setContentOffset(self.tableView.contentOffset,
                                        animated: false)
        self.switchButton.setTitle(viewModel.gender.rawValue,
                                   for: .normal)
        self.switchButton.isHidden = true
        self.load(category: .fullPage)
    }
    
    @objc func pullToRefresh() {
        viewModel.resetPage()
        self.load(category: .fullPage)
    }
    
    // MARK: API Methods
    
    private func load(category: RequestLoading) {
        self.tableView.isUserInteractionEnabled = false
        
        if category == .fullPage {
            viewModel.didLoadPage { [weak self] error in
                if let error = error {
                    self?.showAlert(message: "페이지를 불러올 수 없습니다.\n(\(error.localizedDescription))")
                } else {
                    self?.reload()
                }
            }
        } else {
            viewModel.didNextPage { [weak self] error in
                if let error = error {
                    self?.showAlert(message: "다음 페이지를 불러올 수 없습니다.\n(\(error.localizedDescription))")
                }
                
                self?.reload()
            }
        }
    }
    
    private func reload() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.switchButton.isHidden = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

}

extension UserListViewController: UITableViewDataSource,
                                  UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.users.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserItemCell.identifier, for: indexPath
        ) as? UserItemCell else { return UITableViewCell() }
    
        guard viewModel.users.count > 0 else { return UITableViewCell() }
        
        let cellModel = UserListItemViewModel(user: viewModel.users[indexPath.row])
        
        print("(offset: count real \(viewModel.users.count)")
        
        cell.fill(with: cellModel,
                  imageRepository: self.imageRepository)
        
        if indexPath.row == (viewModel.users.count - 1) {
            load(category: .nextPage)
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        viewModel.didSelectUser(at: indexPath.row)
    }
    
}
