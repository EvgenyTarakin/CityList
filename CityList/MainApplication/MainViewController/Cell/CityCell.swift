//
//  CityCell.swift
//  CityList
//
//  Created by Евгений Таракин on 23.07.2025.
//

import UIKit
import SnapKit

final class CityCell: UITableViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: CityCell.self)
    
    // MARK: - private property
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1088 год"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        
        return label
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
        dateLabel.text = ""
    }

}

// MARK: - func

extension CityCell {
    func configurate(name: String, date: String) {
        nameLabel.text = name
        dateLabel.text = date
    }
}

// MARK: - private func

private extension CityCell {
    func commonInit() {
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        addSubview(separatorView)
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(16)
        }
        separatorView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

