//
//  TabViewController.swift
//  CityList
//
//  Created by Евгений Таракин on 23.07.2025.
//

import UIKit
import SnapKit

// MARK: - State

enum State {
    case tabBar
    case menu
}

// MARK: - TabViewControllerDelegate

protocol TabViewControllerDelegate: AnyObject {
    func didSelectListButton()
    func didSelectMenuButton()
    func didSelectAddListButton()
    func didSelectIndexList(_ index: Int)
}

final class TabViewController: UIViewController {
    
    // MARK: - property
    
    weak var delegate: TabViewControllerDelegate?
    
    // MARK: - private property
    
    private var state: State = .tabBar {
        didSet {
            if state == .tabBar {
                listButton.isHidden = false
                menuButton.isHidden = false
                listNameLabel.isHidden = false
                
                addListButton.isHidden = true
                arrowImageView.isHidden = true
                collectionView.isHidden = true
                fullNameLabel.isHidden = true
            } else {
                listButton.isHidden = true
                menuButton.isHidden = true
                listNameLabel.isHidden = true
                
                addListButton.isHidden = false
                arrowImageView.isHidden = false
                collectionView.isHidden = false
                fullNameLabel.isHidden = false
            }
        }
    }
    
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .black
        
        return separatorView
    }()
    
    // MARK: - TabBar Buttons
    
    private lazy var listButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.addTarget(self, action: #selector(tapListButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(tapMenuButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var listNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        
        return label
    }()
    
    // MARK: - Collection List
    
    private lazy var backAddListButtonView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        
        return backView
    }()
    
    private lazy var addListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapAddListButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.down")
        imageView.tintColor = .black
        
        return imageView
    }()
    
    let requiredView = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let cellWidth = 150
        let leftSectionSpacing = (UIScreen.main.bounds.width - 82) * 0.4
        let cellSpacing = 16.0
        let rightSectionSpacing = (UIScreen.main.bounds.width - 82) * 0.4
        
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: leftSectionSpacing,
                                           bottom: 0,
                                           right: rightSectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuButton.layer.cornerRadius = menuButton.frame.height / 2
        addListButton.layer.cornerRadius = addListButton.frame.height / 2
        addListButton.layer.borderColor = UIColor.black.cgColor
        addListButton.layer.borderWidth = 4
    }

}

// MARK: - func

extension TabViewController {
    func configurate(state: State) {
        self.state = state
        updateData()
    }
}

// MARK: - private func

private extension TabViewController {
    func commonInit() {
        modalPresentationStyle = .automatic
        view.backgroundColor = .white
        
        view.addSubview(separatorView)
        view.addSubview(listButton)
        view.addSubview(menuButton)
        view.addSubview(listNameLabel)
        
        view.addSubview(arrowImageView)
        view.addSubview(collectionView)
        view.addSubview(fullNameLabel)
        view.addSubview(backAddListButtonView)
        view.addSubview(addListButton)
        
        separatorView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        listButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.equalToSuperview().inset(42)
            $0.height.width.equalTo(60)
        }
        menuButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(42)
            $0.height.width.equalTo(40)
        }
        listNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(menuButton)
            $0.top.equalTo(menuButton.snp.bottom).inset(-4)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(60)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(arrowImageView.snp.bottom).inset(-60)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).inset(-24)
            $0.left.right.equalToSuperview()
        }
        backAddListButtonView.snp.makeConstraints {
            $0.top.bottom.equalTo(collectionView)
            $0.left.equalToSuperview()
            $0.width.equalTo(82)
        }
        addListButton.snp.makeConstraints {
            $0.top.equalTo(arrowImageView.snp.bottom).inset(-100)
            $0.left.equalToSuperview().inset(16)
            $0.height.width.equalTo(60)
        }
    }
    
    func updateData() {
        let data = allLists[selectedListIndex]
        menuButton.backgroundColor = data.color
        listNameLabel.text = data.name
        listNameLabel.textColor = data.color
        fullNameLabel.text = data.fullName
    }
}

// MARK: - obj-c

@objc private extension TabViewController {
    func tapListButton() {
        delegate?.didSelectListButton()
    }
    
    func tapMenuButton() {
        state = .menu
        delegate?.didSelectMenuButton()
    }
    
    func tapAddListButton() {
        delegate?.didSelectAddListButton()
    }
}

// MARK: - UICollectionViewDelegate

extension TabViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        selectedListIndex = indexPath.item
        
        updateData()
        delegate?.didSelectIndexList(selectedListIndex)
    }
}

// MARK: - UICollectionViewDataSource

extension TabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier, for: indexPath) as? ListCell
        else { return UICollectionViewCell() }
        cell.configurate(color: allLists[indexPath.item].color)
        
        return cell
    }
}
