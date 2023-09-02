//
//  NewsCollectionViewCell.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import UIKit
import SnapKit
import ExpandableLabel

final class NewsCollectionViewCell: UICollectionViewCell {
    var state: NewsCollectionViewCellState = .normal {
        didSet {
            updateCellState(state)
        }
    }
    private let dateManager = DateManager()
    var infoToShow: Post? {
        didSet {
            titleLabel.text = infoToShow?.title
            messageLabel.text = infoToShow?.previewText
            ratingLabel.text = "❤️ \(infoToShow?.likesCount ?? 0)"
            state = .init(isTextTruncated: messageLabel.isTruncated)
            let timeAgo = dateManager.timeAgoFrom(unixTimestamp: TimeInterval(infoToShow?.timeshamp ?? 0))
            dateLabel.text = timeAgo
        }
    }
    var constraintButton: Constraint?
    //MARK: UI elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "message"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "❤️ 0"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0 days ago"
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    private let expandButton: UIButton = {
        let button = UIButton()
        button.setTitle("Expand", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        return button
    }()
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: UIScreen.main.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let newAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        newAttributes.frame.size = systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return newAttributes
    }
    
    private func updateCellState(_ state: NewsCollectionViewCellState) {
        switch state {
        case .normal:
            expandButton.removeFromSuperview()
            constraintButton?.update(priority: .high)
        case .collapsed:
            addSubview(expandButton)
            expandButton.snp.makeConstraints { make in
                make.top.equalTo(ratingLabel.snp.bottom).offset(Constants.Offsets.top)
                make.horizontalEdges.equalToSuperview().inset(Constants.Offsets.side)
                make.bottom.equalToSuperview()
            }
            constraintButton?.update(priority: .low)
        case .expended:
            expandButton.setTitle("Collapse", for: .normal)
        }
    }
    
    private func setupUI() {
        //title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(Constants.Offsets.side)
        }
        //message
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Offsets.top)
            make.horizontalEdges.equalToSuperview().inset(Constants.Offsets.side)
        }
        //rating
        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(Constants.Offsets.top)
            make.leading.equalToSuperview().offset(Constants.Offsets.side)
            constraintButton = make.bottom.equalToSuperview().priority(.high).constraint
        }
        //date
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel)
            make.top.equalTo(messageLabel.snp.bottom).offset(Constants.Offsets.top)
            make.trailing.equalToSuperview().inset(Constants.Offsets.side)
        }
    }
}
//MARK: - State
extension NewsCollectionViewCell {
    enum NewsCollectionViewCellState {
        case normal
        case collapsed
        case expended
        
        init(isTextTruncated: Bool) {
            if isTextTruncated {
                self = .collapsed
            } else {
                self = .normal
            }
        }
    }
}

//MARK: - Constants
extension NewsCollectionViewCell {
    enum Constants {
        enum Offsets {
            static let top = 10
            static let side = 10
        }
    }
}
