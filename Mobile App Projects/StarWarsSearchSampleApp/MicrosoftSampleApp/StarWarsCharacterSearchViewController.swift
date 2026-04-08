//
//  ViewController.swift
//  MicrosoftSampleApp
//
//  Created by Abhay Curam on 12/8/25.
//

import UIKit

public enum StarWarchCharacterSearchViewControllerStyle {
    case searchBarTop, searchBarBottom
}

public class StarWarsCharacterSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private let cellReuseID = "star-wars-cell-id"
    
    private var searchResults: [CharacterPropertiesContainer] = []
    private var characterSearchService = StarWarsCharacterSearchService()
    private var searchDebouncer = Debouncer(0.4)
    private let presentationStyle: StarWarchCharacterSearchViewControllerStyle
    
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a star wars character"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let resultsTableView = UITableView(frame: .zero, style: .plain)
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        resultsTableView.rowHeight = 60
        return resultsTableView
    }()
    
    public init(_ presentationStyle: StarWarchCharacterSearchViewControllerStyle) {
        self.presentationStyle = presentationStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Character Search"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor.white
        view.addSubview(searchBarView)
        view.addSubview(tableView)
        setupConstraints()
    }

    // MARK: TableViewDelegate + DataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let recycledCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) {
            if !searchResults.isEmpty {
                let characterData = searchResults[indexPath.row]
                recycledCell.textLabel?.text = characterData.properties.name
            }
            return recycledCell
        }
        
        let newCell = UITableViewCell(style: .default, reuseIdentifier: cellReuseID)
        if !searchResults.isEmpty {
            let characterData = searchResults[indexPath.row]
            newCell.textLabel?.text = characterData.properties.name
        }
        return newCell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //present our detail VC next.
        tableView.deselectRow(at: indexPath, animated: true)
        let characterData = searchResults[indexPath.row].properties
        let detailViewController = StarWarsCharacterDetailViewController(characterData)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: UISearchBarDelegate
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchDebouncer.perform { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.characterSearchService.searchForCharacters(searchText, .main) { [weak self] (result, error) in
                    guard let strongSelf = self else { return }
                    if let resultData = result, error == nil {
                        if let currentSearchText = searchBar.text, currentSearchText == searchText {
                            strongSelf.searchResults = resultData.result
                            strongSelf.tableView.reloadData()
                        }
                    }
                }
            }
        } else {
            if !searchResults.isEmpty {
                searchResults.removeAll()
            }
            tableView.reloadData()
        }
    }
    
    private func setupConstraints() {
        var constraints: [NSLayoutConstraint] = []
        if presentationStyle == .searchBarTop {
            constraints = [
                searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
                tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        } else {
            constraints = [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
                searchBarView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
                searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: searchBarView.topAnchor),
            ]
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}

