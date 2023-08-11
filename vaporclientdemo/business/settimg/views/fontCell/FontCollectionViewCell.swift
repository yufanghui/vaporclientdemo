import UIKit
import SnapKit

class FontCollectionViewCell: UICollectionViewCell {

    let label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        return lbl
    }()
    
    var fontInfo:FontInfo? {
        didSet{
            if let info = fontInfo{
                label.text = info.displayName
                self.label.backgroundColor = info.selected ? .red:.white
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
