//
//  SearchCellIView.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import UIKit

class SearchCell : UICollectionViewCell {
    // MARK: - Properties
    
    var viewModel: SearchCellViewModel? {
        didSet{
            configure()
        }
    }
    
    private lazy var ticker: UILabel = {
        let label = UILabel()
        label.text = "BA"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Boeing Company"
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Regular", size: 16)
        return label
    }()
    
    private lazy var countryCode: UILabel = {
        let label = UILabel()
        label.text = "usa"
        label.textColor = .lightGray
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return label
    }()
    
    
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    func configureUI(){
        addSubview(ticker)
        ticker.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        addSubview(countryCode)
        countryCode.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 12, paddingBottom: 10)
        
        var nameWidth = self.layer.frame.width / 1.67
        nameWidth -= 8
        
        addSubview(nameLabel)
        nameLabel.centerY(inView: self)
        nameLabel.anchor(right: rightAnchor, paddingRight: 8, width: nameWidth)
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
    }
    
    func configure(){
        guard let viewModel = viewModel else {
            return
        }

        ticker.text = viewModel.ticker
        countryCode.text = viewModel.typeDefinition
        nameLabel.text = viewModel.name
    }
    
    
}

