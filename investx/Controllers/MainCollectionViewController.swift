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
    
    private var results = [SearchResult](){
        didSet{
            collectionView.reloadData()
        }
    }
    
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
    
    @Published private var query = String()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observeForm()
    }
    
    // MARK: - API
    
    private func observeForm(){
        
        $query.debounce(for: .milliseconds(750), scheduler: RunLoop.main).sink { [unowned self] (query)  in
            self.apiService.fetchSymbolsPublisher(keywords: query).sink { (completion) in
                switch completion {
                case .failure(let error): print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { (searchResult) in
                self.results = searchResult.items
            }.store(in: &self.subscribers)
        }.store(in: &subscribers)
    }
        
    // MARK: - Helpers
    
    func configureUI(){
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        navigationItem.searchController = searchBarView
        definesPresentationContext = false
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
  
}




// MARK: - UISearchBarDelegate

extension MainCollectionViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBarView.searchBar.text , !searchQuery.isEmpty else { return }
        query = searchQuery
        
        print("query value added: \(searchQuery)")
        //apiService.fetchSymbolsPublisher(keywords: searchQuery)
    }
}




// MARK: - UICollectionViewDelegateFlowLayout

extension MainCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        
        let height : CGFloat = 80
        
        return CGSize(width: width, height: height)
    }
}

extension MainCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.viewModel = SearchCellViewModel(searchResult: results[indexPath.row])
        return cell
    }
}
