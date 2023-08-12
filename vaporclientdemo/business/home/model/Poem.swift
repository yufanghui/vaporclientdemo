//
//  Poem.swift
//  vaporclientdemo
//
//  Created by 58 on 2023/8/10.
//

import Foundation
import OpenCC
class Poem {
    var author: String
    var title: String {
        didSet {
            if UserConfiguration.shared.fontChoice == .traditional {
                // 进行简体到繁体的转换
                print("title====加载繁体内容")
                let converter = try! ChineseConverter(options: [.traditionalize, .twStandard, .twIdiom])
                print("转换前\(title)")
                let res =  converter.convert(title)
                print("转换后\(res)")
                title = res
            } else {
                // 加载简体内容
                print("title====加载简体内容")
                let converter = try! ChineseConverter(options: [.simplify, .twStandard, .twIdiom])
                print("转换前\(title)")
                let res =  converter.convert(title)
                print("转换后\(res)")
                title = res
                
            }
            
        }
    }
    var paragraphs: [String] {
        didSet {
            if UserConfiguration.shared.fontChoice == .traditional {
                // 进行简体到繁体的转换
                print("paragraphs===加载繁体内容")
                let converter = try! ChineseConverter(options: [.traditionalize, .twStandard, .twIdiom])
                paragraphs = paragraphs.map { paragraph in
                    print("转换前\(paragraph)")
                    let res =  converter.convert(paragraph)
                    print("转换后\(res)")
                    return res
                }
                
            } else {
                // 加载简体内容
                print("paragraphs===加载简体内容")
                let converter = try! ChineseConverter(options: [.simplify, .twStandard, .twIdiom])
                paragraphs = paragraphs.map { paragraph in
                    print("转换前\(paragraph)")
                    let res =  converter.convert(paragraph)
                    print("转换后\(res)")
                    return res
                }
                
            }
            
        }
    }
    
    init(author: String, title: String, paragraphs: [String]) {
        self.author = author
        self.title = title
        self.paragraphs = paragraphs
    }
}
