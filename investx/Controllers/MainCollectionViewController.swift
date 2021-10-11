//
//  MainCollectionViewController.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import UIKit

private let reuseIdentifier = "SearchCellItem"

class MainCollectionViewController : UICollectionViewController {
    // MARK: - Properties
    
    private lazy var searchBarView : UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Informe um ticker ou nome"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        
        collectionView.backgroundColor = .white
        navigationItem.searchController = searchBarView
        searchBarView.delegate = self
        searchBarView.searchResultsUpdater = self
        definesPresentationContext = false
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
    }
    
}
extension MainCollectionViewController : UISearchControllerDelegate {
    
}

// MARK: - UISearchResultsUpdating

extension MainCollectionViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController){
        guard let searchText = self.searchBarView.searchBar.text else { return }
        print("DEBUG: \(searchText)")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        
        let height : CGFloat = 70
        
        return CGSize(width: width, height: height)
    }
}

extension MainCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        
        return cell
    }
}
