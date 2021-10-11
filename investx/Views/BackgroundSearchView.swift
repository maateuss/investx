//
//  BackgroundSearchView.swift
//  investx
//
//  Created by Mateus Santos on 11/10/21.
//

import UIKit

class BackgroundSearchView : UIView {
    
    // MARK: - Properties
    
    private let icon: UIImageView  = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        let image = #imageLiteral(resourceName: "SearchBackgroundIcon")
        iv.image = image
        return iv
    }()
    
    private let message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Search for companies to calculate potential returns via DCA indicator"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        largeContentTitle = "Test"
        addSubview(icon)
        icon.center(inView: self)
        addSubview(message)
        message.anchor(top: icon.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)
    }
    
}
