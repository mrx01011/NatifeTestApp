//
//  ViewController.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let newsCollectionView: UICollectionView = {
        let cv = UICollectionView()
        return cv
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
    }
    //MARK: Methods
    private func defaultConfigurations() {
        title = "News"
        view.backgroundColor = .white
    }

}

