//
//  LanguageCell.swift
//  vaporclientdemo
//
//  Created by neo on 2023/8/12.
//


import UIKit

class LanguageSwitchCell: UITableViewCell {

    // 定义选择器
    private let languageSwitcher: UISegmentedControl = {
        let items = ["简体", "繁体"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0 // 默认选择简体
        control.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
        return control
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // 将选择器添加到cell中
        contentView.addSubview(languageSwitcher)
        languageSwitcher.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(80)
        }
        if UserConfiguration.shared.fontChoice == .simplified {
            languageSwitcher.selectedSegmentIndex = 0 // 默认选择简体
        }else{
            languageSwitcher.selectedSegmentIndex = 1 // 默认选择简体
        }
    }

    @objc private func languageChanged() {
        switch languageSwitcher.selectedSegmentIndex {
        case 0:
            print("简体被选中")
            // 在这里添加简体的处理逻辑
            UserConfiguration.shared.fontChoice = .simplified
        case 1:
            print("繁体被选中")
            // 在这里添加繁体的处理逻辑
            UserConfiguration.shared.fontChoice = .traditional
        default:
            break
        }
    }
}
