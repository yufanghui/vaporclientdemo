//
//  ColorCollectionViewCell.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    private let selectedBorderWidth: CGFloat = 3.0
    
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        updateSelectionState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateSelectionState() {
        if isSelected {
            self.layer.borderWidth = selectedBorderWidth
            UserConfiguration.shared.favoriteColor = self.backgroundColor
        } else {
            self.layer.borderWidth = 1.0
        }
    }
}

