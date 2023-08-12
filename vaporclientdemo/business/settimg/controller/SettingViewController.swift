//
//  SettingViewController.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import UIKit


protocol SettingViewControllerDelegate: AnyObject {
    func didDismissSettingViewController()
}

class SettingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    weak var delegate: SettingViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRightGesture(_:)))
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeRightGesture)
        view.backgroundColor = .orange
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ColorCell.self, forCellReuseIdentifier: "ColorCell")
        tableView.register(FontCell.self, forCellReuseIdentifier: "FontCell")
        tableView.register(LanguageSwitchCell.self, forCellReuseIdentifier: "LanguageSwitchCell")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.left.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let index = IndexPath(row: 0, section: 1)
            let cell = self.tableView.cellForRow(at: index) as! FontCell
            cell.scrollToSelectIndex()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let index = IndexPath(row: 0, section: 0)
            let cell = self.tableView.cellForRow(at: index) as! ColorCell
            cell.scrollToSelectIndex()
        }
    }
    
    @objc func handleSwipeRightGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            dismiss(animated: true) {
                          self.delegate?.didDismissSettingViewController()
                      }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        switch indexPath.section{
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath) as! FontCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "LanguageSwitchCell", for: indexPath) as! LanguageSwitchCell
        default:
            cell = UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerTitle = ""
        switch section{
        case 0:
            headerTitle = "背景颜色"
        case 1:
            headerTitle = "字体"
        case 2:
            headerTitle = "语言"
        default:
            headerTitle = ""
        }
        return headerTitle
    }
}
