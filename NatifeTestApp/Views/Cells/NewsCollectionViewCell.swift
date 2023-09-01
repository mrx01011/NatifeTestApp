//
//  NewsCollectionViewCell.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import UIKit
import SnapKit
final class NewsCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
