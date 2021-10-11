//
//  MainTabController.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import UIKit

class MainNavigationController: UINavigationController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureNavigationController()
    }
    
    
    
    // MARK: - Helpers
    func configureNavigationController(){
        let mainController = MainCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        pushViewController(mainController, animated: true)
        
    }
    
}
