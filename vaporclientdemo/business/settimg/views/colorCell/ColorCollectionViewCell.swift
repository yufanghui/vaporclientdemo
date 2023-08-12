//
//  ColorCollectionViewCell.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    
    var colorInfo:ColorInfo?{
        didSet{
            if let info = colorInfo {
                self.layer.borderWidth = info.selected ? 3 : 1
                self.backgroundColor = info.color
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

