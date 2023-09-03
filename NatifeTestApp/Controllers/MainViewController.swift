//
//  ViewController.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private var newsArray = [Post]()
    private let networkManager = NetworkManager()
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
        networkManager.getNewsList { [weak self] posts in
            guard let self else { return }
            self.newsArray = posts
            newsCollectionView.reloadData()
        }
        
    }
    //MARK: Methods
    private func defaultConfigurations() {
        title = "News"
        view.backgroundColor = .white
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.and.down.text.horizontal"), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton.tintColor = .black
        navigationItem.rightBarButtonItem = sortButton
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
    
    @objc private func sortButtonTapped() {
        let alertController = UIAlertController(title: "Sort Options", message: "Choose a sorting option", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sort by Rating", style: .default, handler: { (_) in
            self.newsArray.sort { (post1, post2) -> Bool in
                return post1.likesCount > post2.likesCount
            }
            self.newsCollectionView.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "Sort by Date", style: .default, handler: { (_) in
            self.newsArray.sort { (post1, post2) -> Bool in
                return post1.timeshamp > post2.timeshamp
            }
            self.newsCollectionView.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        cell.infoToShow = newsArray[indexPath.row]
        DispatchQueue.main.async {
            cell.state = .init(isTextTruncated: cell.messageLabel.isTruncated())
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPostId = newsArray[indexPath.row].postID
        networkManager.getPostBy(id: selectedPostId) { [weak self] postData in
            guard let self else { return }
            let detailVC = NewsDetailViewController(
                postImageUrl: postData.post.postImage ?? "",
                title: postData.post.title,
                message: postData.post.text ?? "",
                rating: postData.post.likesCount,
                timeStamp: postData.post.timeshamp)
            self.show(detailVC, sender: self)
        }
    }
}
//MARK: - Constants
extension MainViewController {
    enum Constants {
        static let cellIdentifier = "NewsCell"
    }
}


