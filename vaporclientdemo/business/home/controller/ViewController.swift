//
//  ViewController.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/10.
//

import UIKit
import SnapKit
import Toast_Swift
import CoreText

class ViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let paragraphsLabel = UILabel()
    private let scrollView = UIScrollView()
    
    private let floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 30  // This assumes the button size is 60x60
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal) // 使用系统的刷新图标
        button.addTarget(self, action: #selector(nextPoem), for: .touchUpInside)
        return button
    }()
    
    let slideTransitionAnimator = SlideTransitionAnimator()

    
    @objc func nextPoem(){
        loadData(isFirst: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(isFirst: true)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeftGesture(_:)))
               swipeLeftGesture.direction = .left
               view.addGestureRecognizer(swipeLeftGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(with: nil, isFirst: false)
    }
    
    public func updateUI(with poem:Poem?,isFirst:Bool)  {
        DispatchQueue.main.async { [self] in
            if isFirst == false{
                self.view.backgroundColor = UserConfiguration.shared.favoriteColor
                self.updateFont()
            }
            if let po = poem{
                self.titleLabel.text = po.title
                self.authorLabel.text = po.author
                self.paragraphsLabel.text = po.paragraphs.joined(separator: "\n")
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor =  UserConfiguration.shared.favoriteColor ?? .white
        
        view.addSubview(scrollView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view) // 设置内容视图的宽度与滚动视图相同
        }
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(paragraphsLabel)
        
        let fontName = UserConfiguration.shared.favoriteFont ?? "FZJFSB"
        
        titleLabel.font = UIFont(name: fontName, size: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        authorLabel.font = UIFont(name: fontName, size: 18)
        authorLabel.textAlignment = .center
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
        }
        
        paragraphsLabel.font = UIFont(name: fontName, size: 20)
        paragraphsLabel.numberOfLines = 0
        paragraphsLabel.textAlignment = .center
        paragraphsLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        setupFloatingButton()
    }
    
    
    func updateFont() {
        let fontName = UserConfiguration.shared.favoriteFont ?? "FZFSK--GBK1-0"
        
        if let titleFont = UIFont(name: fontName, size: 24) {
            titleLabel.font = titleFont
        }
        
        if let authorFont = UIFont(name: fontName, size: 18) {
            authorLabel.font = authorFont
        }
        
        if let paragraphsFont = UIFont(name: fontName, size: 20) {
            paragraphsLabel.font = paragraphsFont
        }
    }

    
    private func setupFloatingButton() {
        view.addSubview(floatingButton)
        
        // 使用SnapKit布局
        floatingButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
}

