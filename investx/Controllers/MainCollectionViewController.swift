//
//  MainCollectionViewController.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import UIKit
import Combine
import IQKeyboardManagerSwift


private let reuseIdentifier = "SearchCellItem"

class MainCollectionViewController : UICollectionViewController {
    // MARK: - Properties
    
    private lazy var searchBarView : UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Informe um ticker ou nome"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        performSearch()
    }
    
    // MARK: - API
    
    func performSearch(){
        apiService.fetchSymbolsPublisher(keywords: "PETR").sink { (completion) in
            switch completion {
                case .failure(let error): print(error.localizedDescription)
                case .finished: break
            }
        } receiveValue: { (searchResults) in
            print(searchResults)
        }.store(in: &subscribers)

    }
    
    // MARK: - Helpers
    
    func configureUI(){
        
        collectionView.backgroundColor = .white
        navigationItem.searchController = searchBarView
        definesPresentationContext = false
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
  
}




// MARK: - UISearchBarDelegate

extension MainCollectionViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBarView.searchBar.text , !searchQuery.isEmpty else { return }
        
        
        print("Should search for: \(searchQuery)")
        //apiService.fetchSymbolsPublisher(keywords: searchQuery)
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
