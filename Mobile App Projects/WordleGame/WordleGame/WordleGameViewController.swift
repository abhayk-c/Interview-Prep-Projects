//
//  ViewController.swift
//  WordleGame
//
//  Created by Abhay Curam on 12/15/25.
//

import UIKit

public class WordleGameViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    private lazy var textField: UITextField = {
        let textInputField = UITextField(frame: .zero)
        textInputField.textColor = UIColor.black
        textInputField.backgroundColor = UIColor.systemGray
        textInputField.delegate = self
        textInputField.translatesAutoresizingMaskIntoConstraints = false
        return textInputField
    }()
    
    private lazy var gridFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let interSpecing: CGFloat = 2
        flowLayout.minimumInteritemSpacing = interSpecing
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
        let frameWidth = view.frame.width
        let gridWidth = (frameWidth - 40 - (4 * interSpecing)) / 5
        flowLayout.itemSize = CGSize(width: gridWidth, height: gridWidth)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "grid-cell-id")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var characterGrid: [[Character]] = []
    private var currentRow = 0
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        let row: [Character] = Array(repeating: " ", count: 5)
        self.characterGrid = Array(repeating: row, count: 6)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    //Mark: CollectionViewDelegate + DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recycledCell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid-cell-id", for: indexPath)
        recycledCell.backgroundColor = UIColor.lightGray
        return recycledCell
    }
    
    //MARK: UITextFieldDelegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let inputWord = textField.text, currentRow < 6 {
            let inputCharacterArray = Array(inputWord)
            updateGridCollection(inputCharacterArray)
        }
        return true
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40),
            collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateGridCollection(_ inputCharacters: [Character]) {
        let colCount = characterGrid[0].count
        for i in 0..<colCount {
            characterGrid[currentRow][i] = inputCharacters[i]
        }
        collectionView.reloadData()
    }

}

