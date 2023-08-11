//
//  ColorCell.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit

class ColorCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var colors: [UIColor] = [
        UIColor(red: 0.941, green: 0.960, blue: 0.941, alpha: 1.0), // 带有轻微的绿色的白色
        UIColor(red: 0.961, green: 0.949, blue: 0.925, alpha: 1.0), // 带有轻微的棕色的白色
        UIColor(red: 0.933, green: 0.941, blue: 0.960, alpha: 1.0), // 带有轻微的蓝色的白色
        UIColor(red: 0.960, green: 0.949, blue: 0.949, alpha: 1.0), // 带有轻微的红色的白色
        UIColor(red: 0.949, green: 0.960, blue: 0.941, alpha: 1.0), // 带有轻微的绿色的白色
        UIColor(red: 0.933, green: 0.933, blue: 0.910, alpha: 1.0), // 亚麻色
        UIColor(red: 0.898, green: 0.933, blue: 0.920, alpha: 1.0), // 淡青色
        UIColor(red: 0.961, green: 0.961, blue: 0.933, alpha: 1.0), // 花白色
        UIColor(red: 0.949, green: 0.933, blue: 0.898, alpha: 1.0), // 淡棕色
        UIColor(red: 0.941, green: 0.918, blue: 0.918, alpha: 1.0), // 粉色
        UIColor(red: 0.933, green: 0.929, blue: 0.898, alpha: 1.0), // 米色
        UIColor(red: 0.918, green: 0.941, blue: 0.933, alpha: 1.0), // 淡绿色
        UIColor(red: 0.941, green: 0.933, blue: 0.910, alpha: 1.0), // 米黄色
        UIColor(red: 0.910, green: 0.941, blue: 0.918, alpha: 1.0), // 青色
        UIColor(red: 0.949, green: 0.941, blue: 0.918, alpha: 1.0), // 沙色
        UIColor(red: 0.929, green: 0.929, blue: 0.898, alpha: 1.0), // 灰白色
        UIColor(red: 0.910, green: 0.918, blue: 0.941, alpha: 1.0), // 淡蓝色
        UIColor(red: 0.918, green: 0.918, blue: 0.898, alpha: 1.0), // 灰色
        UIColor(red: 0.910, green: 0.910, blue: 0.898, alpha: 1.0), // 银色
        UIColor(red: 0.933, green: 0.933, blue: 0.918, alpha: 1.0)  // 骨色
    ]


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
        
        for _ in 0..<10{
            colors.append(UIColor.randomColor)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        let color = colors[indexPath.item]
        cell.backgroundColor = color
        let color1Components = color.components
        let color2Components = UserConfiguration.shared.favoriteColor?.components

//        if let c1 = color1Components, let c2 = color2Components, c1.red == c2.red, c1.green == c2.green, c1.blue == c2.blue, c1.alpha == c2.alpha {
//            print("The colors are the same.")
//            cell.isSelected = true
//        } else {
//            print("The colors are different.")
//            cell.isSelected = false
//        }
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
    
    func scrollToSelectIndex()  {
        let row = colors.firstIndex(of: UserConfiguration.shared.favoriteColor ?? .white) ?? 0
        let selectIndex = IndexPath(row: row, section: 0)
        collectionView.scrollToItem(at: selectIndex, at: .left, animated: true)
    }
}
