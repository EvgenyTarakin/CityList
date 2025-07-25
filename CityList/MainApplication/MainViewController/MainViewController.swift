//
//  MainViewController.swift
//  CityList
//
//  Created by Евгений Таракин on 23.07.2025.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - private property
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Изменить",
                                     style: .plain,
                                     target: self,
                                     action: #selector(tapEditButton))
        button.isHidden = true
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        return tableView
    }()
    
    private lazy var tabViewController: TabViewController = {
        let tabViewController = TabViewController()
        tabViewController.delegate = self

        return tabViewController
    }()
    
    private lazy var sheet = tabViewController.sheetPresentationController
    
    // MARK: - ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showTabBar()
    }

}

// MARK: - private func

private extension MainViewController {
    func commonInit() {
        title = "Города"
        navigationItem.rightBarButtonItem = editButton
        
        view.backgroundColor = .white

        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func showTabBar() {
        tabViewController.configurate(state: .tabBar)
        if let sheet = tabViewController.sheetPresentationController {
            sheet.delegate = self
            sheet.detents = [.fix(70), .medium(), .fix((view.frame.height - 104))]
            sheet.preferredCornerRadius = 0
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(tabViewController, animated: true, completion: nil)
    }
    
    func hideTabBar() {
        tabViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - obj-c

@objc private extension MainViewController {
    func tapEditButton() {
        tableView.isEditing.toggle()
        if tableView.isEditing {
            editButton.title = "Готово"
            hideTabBar()
        } else {
            editButton.title = "Изменить"
            showTabBar()
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        allLists[selectedListIndex].indexesCities.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLists[selectedListIndex].indexesCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseIdentifier, for: indexPath) as? CityCell
        else { return UITableViewCell() }
        let city = allCities[allLists[selectedListIndex].indexesCities[indexPath.row]]
        cell.configurate(name: city.name, date: city.date)
        
        return cell
    }
}

// MARK: - TabViewControllerDelegate

extension MainViewController: TabViewControllerDelegate {
    func didSelectListButton() {
        tableView.isHidden = false
        editButton.isHidden = false
    }
    
    func didSelectMenuButton() {
        let sheet = tabViewController.sheetPresentationController
        sheet?.animateChanges {
            sheet?.selectedDetentIdentifier = .medium
        }
    }
    
    func didSelectAddListButton() {
        hideTabBar()
        let controller = AddNewListViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didSelectIndexList(_ index: Int) {
        let sheet = tabViewController.sheetPresentationController
        sheet?.animateChanges {
            sheet?.selectedDetentIdentifier = sheet?.detents.first?.identifier
        }
        tabViewController.configurate(state: .tabBar)
        tableView.isHidden = true
        editButton.isHidden = true
        tableView.reloadData()
    }
}

// MARK: - UISheetPresentationControllerDelegate

extension MainViewController: UISheetPresentationControllerDelegate {
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false
    }
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == tabViewController.sheetPresentationController?.detents.first?.identifier {
            tabViewController.configurate(state: .tabBar)
        } else {
            tabViewController.configurate(state: .menu)
        }
    }
}
