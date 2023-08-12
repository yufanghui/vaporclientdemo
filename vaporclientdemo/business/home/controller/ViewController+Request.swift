//
//  ViewControllerUIExtension.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/11.
//

import Foundation

extension ViewController{
    
    @objc func loadData(isFirst:Bool) {
        let url = "\(NetTool.baseUrl)/tangshi"
        NetTool.makeGetRequest(to: url) { result in
            switch result {
            case .success(let response):
                print(response)
                let poem = self.parseData(response as! [String : Any])
                self.updateUI(with: poem,isFirst: isFirst)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func parseData(_ data: [String: Any]) -> Poem {
        let author = data["author"] as! String
        let title = data["title"] as! String
        let paragraphs = data["paragraphs"] as! [String]
        let poem = Poem(author: author, title: title, paragraphs: paragraphs)
        poem.paragraphs.append("") // 这应该会触发didSet
        poem.title.append("")
        poem.author.append("")
        self.poem = poem
        return poem
    }
}
