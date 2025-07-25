//
//  ListCell.swift
//  CityList
//
//  Created by Евгений Таракин on 25.07.2025.
//

import UIKit
import SnapKit

final class ListCell: UICollectionViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: ListCell.self)
    
    // MARK: - private property
    
    private lazy var colorView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        
        return backView
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - override func
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = colorView.bounds.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorView.backgroundColor = .clear
    }
    
}

// MARK: - func

extension ListCell {
    func configurate(color: UIColor) {
        colorView.backgroundColor = color
    }
}

// MARK: - private func

private extension ListCell {
    func commonInit() {
        backgroundColor = .clear
        
        addSubview(colorView)
        
        colorView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
