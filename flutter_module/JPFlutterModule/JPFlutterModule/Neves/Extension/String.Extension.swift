//
//  String.Extension.swift
//  Neves_Example
//
//  Created by 周健平 on 2020/10/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

//extension String: JPCompatible {}
//extension NSString: JPCompatible {}
//extension JP where Base: ExpressibleByStringLiteral {
//    
//}

extension String {
    var isContainsChinese: Bool {
        let str = self as NSString
        for i in 0..<str.length {
            let a = str.character(at: i)
            if a > 0x4e00, a < 0x9fff {
                return true
            }
        }
        return false
    }
    
    func textSize(withFont font: UIFont,
                  lineSpace: CGFloat,
                  isOneLine: inout Bool,
                  maxSize: CGSize = .init(width: 999, height: 999)) -> CGSize {
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = font
        
        if lineSpace > 0 {
            let parag = NSMutableParagraphStyle()
            parag.lineSpacing = lineSpace
            attributes[.paragraphStyle] = parag
        }
        
        var rect = (self as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        // 文本的高度 - 字体高度 > 行间距 -----> 判断为当前超过1行
        let isMoreThanOneLine = (rect.size.height - font.lineHeight) > lineSpace
        if !isMoreThanOneLine, self.isContainsChinese {
            rect.size.height -= lineSpace
        }
        
        if rect.size.height > 0, rect.size.height < font.pointSize {
            rect.size.height = font.pointSize
        }
        
        isOneLine = !isMoreThanOneLine
        return rect.size
    }
    
}
