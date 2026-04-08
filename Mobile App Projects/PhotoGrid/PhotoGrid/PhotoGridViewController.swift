//
//  ViewController.swift
//  PhotoGrid
//
//  Created by Abhay Curam on 12/14/25.
//

import UIKit

public class PhotoGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private lazy var gridLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let itemWidth = (view.frame.width - 40 - 10) / 2
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "grid_cell_id")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    //MARK: UICollectionViewDataSource + Delegate
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid_cell_id", for: indexPath)
        collectionViewCell.backgroundColor = UIColor.systemGray
        return collectionViewCell
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

