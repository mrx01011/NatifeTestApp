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
