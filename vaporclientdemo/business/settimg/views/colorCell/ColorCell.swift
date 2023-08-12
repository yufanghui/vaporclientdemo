//
//  ColorCell.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit

class ColorCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var colors: [String] = [
        "#F5E7E0","#E8F4F2","#E8E8F4","#FFF4E8","#F4E8E8",
        "#E0F5E7","#E0E0F5","#F5F4E0","#F4F4F4","#E7F5E0",
        "#333333","#1E1E1E","#004466","#2E0854","#003322",
        "#550000","#003366","#2F4F4F","#4B0082","#8B4513"
    ]
    
    var colorInfos:[ColorInfo] = [ColorInfo]()
    
    var lastColorInfo:ColorInfo?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "ColorCollectionViewCell")
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        for color in colors{
            
            var selected = false
            
            if color == UserConfiguration.shared.favoriteColor
            {
                selected = true
            }else{
                selected = false
            }
            var colorInfo = ColorInfo(selected: selected, colorString: color)
            
            if selected{
                lastColorInfo = colorInfo
            }
            
            colorInfos.append(colorInfo)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        cell.colorInfo = colorInfos[indexPath.item]
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info = colorInfos[indexPath.item]
        if info.colorString == UserConfiguration.shared.favoriteColor{
            return
        }
        self.lastColorInfo?.selected.toggle()
        info.selected.toggle()
        self.lastColorInfo = info
        UserConfiguration.shared.favoriteColor = info.colorString
        collectionView.reloadData()
    }
    
    func scrollToSelectIndex()  {
        let row = colors.firstIndex(of: UserConfiguration.shared.favoriteColor ?? "#333333") ?? 0
        let selectIndex = IndexPath(row: row, section: 0)
        collectionView.scrollToItem(at: selectIndex, at: .left, animated: true)
    }
}
