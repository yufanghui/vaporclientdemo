//
//  FontCell.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit
import SnapKit

class FontCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var fonts: [String] = [
        "FZFSK--GBK1-0",
//        "FZFSJW--GB1-0",
//        "FZFSFW--GB1-0",
        "FZFSB--B51-0",
        "FZHTFW--GB1-0",
        "FZHTB--B51-0",
        "FZJFSB--B51-0",
        "FZJKTB--B51-0",
        "FZJSSB--B51-0",
        "FZKTK--GBK1-0",
//        "FZKTJW--GB1-0",
//        "FZKTFW--GB1-0",
        "FZKTB--B51-0",
        "FZSSK--GBK1-0",
        "FZSSJW--GB1-0",
        "FZSSFW--GB1-0",
        "FZWUYRXSJF--GBK1-0",
        "FZZHAOMFXSJF--GBK1-0",
        "FZZJ-GFXLXSJF--GBK1-0",
        "FZZJ-GFXLXSJW--GB1-0",
        "FZZJ-HYWKJF--GBK1-0",
        "FZZJ-SYTJW--GB1-0"
    ]// 示例字体名称，根据需要更改
    var fontNames:[String] = []
    var fontInfos:[String:String] = [:]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(FontCollectionViewCell.self, forCellWithReuseIdentifier: "FontCollectionViewCell")
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for name in fonts{
            if let displayName = displayName(forFont: UIFont(name: name, size: 24) ?? UIFont.systemFont(ofSize: 17)) {
                print("Display name: \(displayName)")
                fontNames.append(displayName)
                fontInfos[displayName] = name
            }
        }
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
          
    }
    
    func scrollToSelectIndex()  {
        let row = fonts.firstIndex(of: UserConfiguration.shared.favoriteFont ?? "") ?? 0
        let selectIndex = IndexPath(row: row, section: 0)
        collectionView.scrollToItem(at: selectIndex, at: .left, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FontCollectionViewCell", for: indexPath) as! FontCollectionViewCell
        let displayName = fontNames[indexPath.item]
        let name = fontInfos[displayName]
        cell.label.text = fontNames[indexPath.item]
        cell.label.font = UIFont(name: fontNames[indexPath.item], size: 16)
        cell.font = name
        if name == UserConfiguration.shared.favoriteFont{
            cell.isSelected = true
        }else{
            cell.isSelected = false
        }
        return cell
    }
    
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = fontNames[indexPath.item] // 获取文本，这里的dataSource是你的数据源数组
        let font = UIFont.systemFont(ofSize: 16.0)
        let width = widthForText(text, font: font) + 20
        return CGSize(width: width, height: 50) // 这里的高度可以根据你的需求来定
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
    
    
    func widthForText(_ text: String, font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width
    }
    
    func displayName(forFont font: UIFont) -> String? {
        let fontRef = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        return CTFontCopyDisplayName(fontRef) as String?
    }
}
