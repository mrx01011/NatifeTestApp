//
//  ViewController.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let newsArray = ["Test"]
    //MARK: UI elements
    private let newsCollectionView: UICollectionView = {
        let newsFlowLayout = UICollectionViewFlowLayout()
        newsFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: newsFlowLayout)
        cv.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        return cv
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
        setupUI()
        setupDelegates()
    }
    //MARK: Methods
    private func defaultConfigurations() {
        title = "News"
        view.backgroundColor = .white
    }

    private func setupUI() {
        view.addSubview(newsCollectionView)
        newsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupDelegates() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        cell.infoToShow = Post(postID: 143, timeshamp: 1645030659, title: "Test", previewText: "TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST", likesCount: 356)
        return cell
    }
    
    
}
//MARK: - Constants
extension MainViewController {
    enum Constants {
        static let cellIdentifier = "NewsCell"
    }
}


