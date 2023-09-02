//
//  NewsDetailViewController.swift
//  NatifeTestApp
//
//  Created by MacBook on 02.09.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class NewsDetailViewController: UIViewController {
    private let dateManager = DateManager()
    //MARK: UI elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let postImageView = UIImageView()
    private let postTitle: UILabel = {
        let label = UILabel()
        label.text = "Some title"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "some description"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
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
        label.text = ""
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    //MARK: Initialization
    init(postImageUrl: String, title: String, message: String, rating: Int, timeStamp: Int) {
        super.init(nibName: nil, bundle: nil)
        postImageView.sd_setImage(with: URL(string: postImageUrl))
        postTitle.text = title
        messageLabel.text = message
        ratingLabel.text = "❤️\(rating)"
        dateLabel.text = dateManager.dateFrom(unixTimestamp: TimeInterval(timeStamp))
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
        setupUI()
    }
    //MARK: Methods
    private func defaultConfigurations() {
        title = "Post"
        view.backgroundColor = .white
    }
    
    private func setupUI() {
        //scroll view
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        //post image view
        contentView.addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
        //title
        contentView.addSubview(postTitle)
        postTitle.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(Constants.Offsets.top)
            make.horizontalEdges.equalToSuperview().inset(Constants.Offsets.side)
        }
        //message label
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(postTitle.snp.bottom).offset(Constants.Offsets.top)
            make.horizontalEdges.equalToSuperview().inset(Constants.Offsets.side)
        }
        //rating label
        contentView.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(Constants.Offsets.top)
            make.leading.equalToSuperview().offset(Constants.Offsets.side)
            make.bottom.lessThanOrEqualToSuperview()
        }
        //date label
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel)
            make.top.equalTo(messageLabel.snp.bottom).offset(Constants.Offsets.top)
            make.trailing.equalToSuperview().inset(Constants.Offsets.side)
        }
    }
}
//MARK: - Constants
extension NewsDetailViewController {
    enum Constants {
        enum Offsets {
            static let top = 10
            static let side = 10
        }
    }
}
