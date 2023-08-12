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
//        "FZFSB--B51-0",
//        "FZHTFW--GB1-0",
//        "FZHTB--B51-0",
//        "FZJFSB--B51-0",
//        "FZJKTB--B51-0",
//        "FZJSSB--B51-0",
        "FZKTK--GBK1-0",
//        "FZKTJW--GB1-0",
//        "FZKTFW--GB1-0",
//        "FZKTB--B51-0",
        "FZSSK--GBK1-0",
        "FZSSJW--GB1-0",
        "FZSSFW--GB1-0",
        "FZWUYRXSJF--GBK1-0",
        "FZZHAOMFXSJF--GBK1-0",
        "FZZJ-GFXLXSJF--GBK1-0",
        "FZZJ-GFXLXSJW--GB1-0",
        "FZZJ-HYWKJF--GBK1-0",
        "FZZJ-SYTJW--GB1-0"
    ]
    var fontInfos:[FontInfo] = [FontInfo]()
    var lastSelectedInfo:FontInfo?
    
    
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
            let selected = (name == UserConfiguration.shared.favoriteFont)
            
            if let displayName = displayName(forFont: UIFont(name: name, size: 24) ?? UIFont.systemFont(ofSize: 17)) {
                let fontInfo = FontInfo(fontName: name, displayName: displayName, selected: selected)
                fontInfos.append(fontInfo)
                if selected {
                    self.lastSelectedInfo = fontInfo
                }
            }
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
       
    }
    
    func scrollToSelectIndex()  {
        let row = fonts.firstIndex(of: UserConfiguration.shared.favoriteFont ?? "") ?? 0
        let selectedIndex = IndexPath(row: row, section: 0)
        collectionView.scrollToItem(at: selectedIndex, at: .left, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FontCollectionViewCell", for: indexPath) as! FontCollectionViewCell
        cell.fontInfo = fontInfos[indexPath.item]
        return cell
    }
    
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fontInfo = fontInfos[indexPath.item] // 获取文本，这里的dataSource是你的数据源数组
        let font = UIFont.systemFont(ofSize: 16.0)
        let width = widthForText(fontInfo.displayName!, font: font) + 20
        return CGSize(width: width, height: 50) // 这里的高度可以根据你的需求来定
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var info = fontInfos[indexPath.item]
        if self.lastSelectedInfo?.fontName == info.fontName{
            return
        }
        self.lastSelectedInfo?.selected.toggle()
        info.selected.toggle()
        self.lastSelectedInfo = info
        UserConfiguration.shared.favoriteFont = info.fontName
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
