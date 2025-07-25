//
//  NewCityCell.swift
//  CityList
//
//  Created by Евгений Таракин on 23.07.2025.
//

import UIKit
import SnapKit

final class NewCityCell: UITableViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: NewCityCell.self)
    
    // MARK: - private property
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Москва"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .black
        
        return separatorView
    }()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        checkmarkImageView.isHidden = true
    }

}

// MARK: - func

extension NewCityCell {
    func configurate(name: String) {
        nameLabel.text = name
    }
    
    func configurate(isSelected: Bool) {
        checkmarkImageView.isHidden = !isSelected
    }
}

// MARK: - private func

private extension NewCityCell {
    func commonInit() {
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(separatorView)
        addSubview(checkmarkImageView)
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        checkmarkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(16)
            $0.height.width.equalTo(24)
        }
    }
}


