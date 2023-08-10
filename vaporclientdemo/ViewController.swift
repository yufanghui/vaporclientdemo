//
//  ViewController.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/10.
//

import UIKit
import SnapKit

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
        button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }
    
    func isRunningOnSimulator() -> Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    
    @objc func loadData() {
        var host = "127.0.0.1"
        // 使用
        if isRunningOnSimulator() {
            print("App is running on Simulator")
        } else {
            print("App is running on a real device")
            host = "10.252.196.114"
        }

        let url = "http://\(host):8080/tangshi"
        makeGetRequest(to: url) { result in
            switch result {
            case .success(let response):
                print(response)
                let poem = self.parseData(response as! [String : Any])
                self.updateUI(with: poem)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func updateUI(with poem:Poem)  {
        DispatchQueue.main.async { [self] in
            self.titleLabel.text = poem.title
            self.authorLabel.text = poem.author
            self.paragraphsLabel.text = poem.paragraphs.joined(separator: "\n")
        }
    }
    
    func setupUI() {
        view.backgroundColor = .randomBgColor
        
        view.addSubview(scrollView)
        
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
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        authorLabel.font = UIFont.systemFont(ofSize: 18)
        authorLabel.textAlignment = .center
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
        }
        
        paragraphsLabel.font = UIFont.systemFont(ofSize: 20)
        paragraphsLabel.numberOfLines = 0
        paragraphsLabel.textAlignment = .center
        paragraphsLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        setupFloatingButton()
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
    
    func parseData(_ data: [String: Any]) -> Poem {
        let author = data["author"] as! String
        let title = data["title"] as! String
        let paragraphs = data["paragraphs"] as! [String]
        
        return Poem(author: author, title: title, paragraphs: paragraphs)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        // 使用
        //        let url = "http://127.0.0.1:8080/greeting"
        //        let parameters = ["name": "zhangsan"]
        //        makePostRequest(to: url, parameters: parameters) { result in
        //            switch result {
        //            case .success(let response):
        //                print(response)
        //            case .failure(let error):
        //                print("Error: \(error.localizedDescription)")
        //            }
        //        }
        
        // 使用
        
        
    }
    
    func makeGetRequest(
        to url: String,
        completion: @escaping (Result<Any, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                completion(.success(jsonResponse))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }
        
        task.resume()
    }
    
    
    func makePostRequest(
        to url: String,
        parameters: [String: Any],
        completion: @escaping (Result<Any, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                completion(.success(jsonResponse))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }
        
        task.resume()
    }
}

