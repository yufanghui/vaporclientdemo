import UIKit
import SnapKit

class FontCollectionViewCell: UICollectionViewCell {

    let label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()
    
    var font:String?
    

    private let selectedBorderWidth: CGFloat = 3.0

    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        self.layer.borderColor = UIColor.gray.cgColor
        updateSelectionState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateSelectionState() {
        if isSelected {
            self.layer.borderWidth = selectedBorderWidth
            UserConfiguration.shared.favoriteFont = self.font
        } else {
            self.layer.borderWidth = 1.0
        }
    }
}
