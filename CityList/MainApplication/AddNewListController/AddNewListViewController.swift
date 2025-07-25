//
//  AddNewListViewController.swift
//  CityList
//
//  Created by Евгений Таракин on 23.07.2025.
//

import UIKit
import SnapKit

final class AddNewListViewController: UIViewController {
    
    // MARK: - private property
    
    private var selectedIndexes: [Int] = []
    
    private lazy var shortNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shortNameLabel, shortNameTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        
        shortNameLabel.snp.makeConstraints {
            $0.width.equalTo(145)
        }
        
        return stackView
    }()
    
    private lazy var shortNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Короткое имя списка"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var shortNameTextField: UITextField = {
        let textField = UITextField()
        textField.set()
        
        return textField
    }()
    
    private lazy var fullNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        
        fullNameLabel.snp.makeConstraints {
            $0.width.equalTo(145)
        }
        
        return stackView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Полное имя списка"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.set()
        
        return textField
    }()
    
    private lazy var colorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [colorLabel, colorButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        
        colorLabel.snp.makeConstraints {
            $0.width.equalTo(145)
        }
        
        return stackView
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет списка"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Зеленый", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(tapColorButton), for: .touchUpInside)
        button.menu = colorMenu
        
        return button
    }()
    
    private lazy var colorMenu: UIMenu = {
        let menu = UIMenu(title: "Выберите цвет",
                          options: .singleSelection,
                          children:
                            [UIAction(title: "Синий", handler: { [weak self] _ in
            guard let self else { return }
            colorButton.setTitle("Синий", for: .normal)
            colorButton.setTitleColor(.systemBlue, for: .normal)
        }),UIAction(title: "Красный", handler: {[weak self] _ in
            guard let self else { return }
            colorButton.setTitle("Красный", for: .normal)
            colorButton.setTitleColor(.systemRed, for: .normal)
        }),UIAction(title: "Зеленый", handler: { [weak self] _ in
            guard let self else { return }
            colorButton.setTitle("Зеленый", for: .normal)
            colorButton.setTitleColor(.systemGreen, for: .normal)
        }),UIAction(title: "Желтый", handler: { [weak self] _ in
            guard let self else { return }
            colorButton.setTitle("Желтый", for: .normal)
            colorButton.setTitleColor(.systemYellow, for: .normal)
        }),UIAction(title: "Серый", handler: { [weak self] _ in
            guard let self else { return }
            colorButton.setTitle("Серый", for: .normal)
            colorButton.setTitleColor(.systemGray, for: .normal)
        })
                            ])
        
        return menu
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.register(NewCityCell.self, forCellReuseIdentifier: NewCityCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, addButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Ок", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        
        return button
    }()

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

}

// MARK: - private func

private extension AddNewListViewController {
    func commonInit() {
        title = "Новый список городов"
        
        view.backgroundColor = .white
        
        view.addSubview(shortNameStackView)
        view.addSubview(fullNameStackView)
        view.addSubview(colorStackView)
        view.addSubview(buttonStackView)
        view.addSubview(tableView)
        
        shortNameStackView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
        fullNameStackView.snp.makeConstraints {
            $0.top.equalTo(shortNameStackView.snp.bottom).inset(-16)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
        colorStackView.snp.makeConstraints {
            $0.top.equalTo(fullNameStackView.snp.bottom).inset(-16)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
        buttonStackView.snp.makeConstraints {
            $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(colorStackView.snp.bottom).inset(-16)
            $0.bottom.equalTo(buttonStackView.snp.top).inset(-16)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - obj-c

@objc private extension AddNewListViewController {
    func tapColorButton() {
        colorButton.showsMenuAsPrimaryAction = true
    }
    
    func tapCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func tapAddButton() {
        if shortNameTextField.text ?? "" != "" && fullNameTextField.text ?? "" != "" && !selectedIndexes.isEmpty {
            allLists.append(List(name: shortNameTextField.text ?? "",
                                 fullName: fullNameTextField.text ?? "",
                                 color: colorButton.titleLabel?.textColor ?? .systemGreen,
                                 indexesCities: selectedIndexes))
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UITableViewDelegate

extension AddNewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath.row) {
            if let index = selectedIndexes.firstIndex(of: indexPath.row) {
                selectedIndexes.remove(at: index)
            }
        } else {
            if selectedIndexes.count < 5 {
                selectedIndexes.append(indexPath.row)
            }
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension AddNewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewCityCell.reuseIdentifier, for: indexPath) as? NewCityCell
        else { return UITableViewCell() }
        let city = allCities[indexPath.row]
        cell.configurate(name: city.name)
        cell.configurate(isSelected: selectedIndexes.contains(indexPath.row))
        
        return cell
    }
}
