//
//  UILabel + Extension.swift
//  NatifeTestApp
//
//  Created by MacBook on 02.09.2023.
//

import UIKit

extension UILabel {
    var isTruncated: Bool {
        return intrinsicContentSize.width > UIScreen.main.bounds.width * 2 - 32
    }
}
