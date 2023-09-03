//
//  UILabel + Extension.swift
//  NatifeTestApp
//
//  Created by MacBook on 02.09.2023.
//

import UIKit

extension UILabel {
    func countLabelLines() -> Int {
        self.layoutIfNeeded()
        guard let myText = self.text as? NSString else { return 0 }
        let attributes = [NSAttributedString.Key.font : self.font]
        let labelSize = myText.boundingRect(
            with: CGSize(width: self.bounds.width,
                         height: CGFloat.greatestFiniteMagnitude),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: attributes as [NSAttributedString.Key : Any],
            context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }

    func isTruncated() -> Bool {
        self.layoutIfNeeded()
        if (self.countLabelLines() > self.numberOfLines) {
            return true
        }
        return false
    }
}
//extension UILabel {
//    func countLabelLines() -> Int {
//        // Определяем текущий контейнер для текста
//        let textContainer = NSTextContainer(size: CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
//        textContainer.lineBreakMode = self.lineBreakMode
//        textContainer.maximumNumberOfLines = self.numberOfLines
//
//        // Создаем layoutManager и добавляем текстовый контейнер
//        let layoutManager = NSLayoutManager()
//        layoutManager.addTextContainer(textContainer)
//
//        // Создаем строку для измерения
//        let textStorage = NSTextStorage(attributedString: self.attributedText ?? NSAttributedString(string: self.text ?? ""))
//        textStorage.addLayoutManager(layoutManager)
//
//        // Измеряем высоту текста
//        var numberOfLines = 0
//        var index = 0
//        var lineRange : NSRange = NSRange(location: 0, length: 0)
//
//        while (index < layoutManager.numberOfGlyphs) {
//            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
//            index = NSMaxRange(lineRange)
//            numberOfLines += 1
//        }
//
//        return numberOfLines
//    }
//
//    func isTruncated() -> Bool {
//        self.layoutIfNeeded()
//        return self.countLabelLines() > self.numberOfLines
//    }
//}
