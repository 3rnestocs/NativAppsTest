//
//  HomeViewController.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var buttonView: UIView!
    
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.reportCompletion = {
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: HomeTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    @IBAction private func addButtonTapped(_ sender: UIButton) {
        guard let addReportVC = getVC(.addReportVC) as? AddReportViewController else { return }
        if let sheet = addReportVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        addReportVC.delegate = self
        self.present(addReportVC, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.getReports().isEmpty {
            tableView.emptyMessage(message: "No hay registros todavia.")
        } else {
            tableView.backgroundView = nil
            return viewModel.getReports().count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellIdentifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(viewModel.getReports()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension HomeViewController: AddReportViewControllerDelegate {
    func didSave() {
        viewModel.updateReports()
    }
}
