//
//  EquityDetailController.swift
//  investx
//
//  Created by Mateus Santos on 13/10/21.
//


import UIKit

class EquityDetailViewController : UIViewController {
    // MARK: - Properties
    
    var equity: SearchResult?
    
    private lazy var equityDetailsLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = equity?.name ?? ""
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: FontStyle.medium.rawValue, size: 16)
        return label
        
    }()
    
    private lazy var currentValueLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text =  "Current Value"
        label.font = UIFont(name: FontStyle.medium.rawValue, size: 14)
        return label
    }()
    
    private lazy var currentValueField : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text =  "0.00"
        label.font = UIFont(name: FontStyle.demiBold.rawValue, size: 20)
        return label
    }()
    
    private lazy var investmentLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text =   "Investment amount"
        label.font = UIFont(name: FontStyle.medium.rawValue, size: 14)
        return label
    }()
    
    private lazy var investmentValue : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text =  "0.00"
        label.font = UIFont(name: FontStyle.demiBold.rawValue, size: 14)
        return label
        
    }()
    
    private lazy var gainLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text =   "Gain"
        label.font = UIFont(name: FontStyle.medium.rawValue, size: 14)
        return label
    }()
    
    private lazy var gainValue : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text =  "0.00"
        label.font = UIFont(name: FontStyle.demiBold.rawValue, size: 14)
        return label
    }()
    
    private lazy var percentualGainValue : UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text =  "0.00"
        label.font = UIFont(name: FontStyle.demiBold.rawValue, size: 14)
        return label
    }()
    
    private lazy var annualReturnLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Annual return"
        label.font = UIFont(name: FontStyle.medium.rawValue, size: 14)
        return label
    }()
    
    private lazy var annualReturnValue : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text =  "0.00"
        label.font = UIFont(name: FontStyle.demiBold.rawValue, size: 14)
        return label
    }()
    
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI(){
        
        view.backgroundColor = .white
        if let ticker = equity?.ticker {
            configureNavigationBar(title: ticker)
        }
        
        
        view.addSubview(equityDetailsLabel)
        equityDetailsLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 2, paddingLeft: 16, paddingRight: 16)
        
        let stack = UIStackView(arrangedSubviews: [currentValueLabel, currentValueField])
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .fillProportionally
        view.addSubview(stack)
        stack.anchor(top: equityDetailsLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 2, paddingLeft: 16, paddingRight: 16, height: 40)
        
        let messagesStack = UIStackView(arrangedSubviews: [investmentLabel, gainLabel, annualReturnLabel])
        messagesStack.axis = .vertical
        messagesStack.spacing = 2
        messagesStack.distribution = .fillEqually
        view.addSubview(messagesStack)
        messagesStack.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16,height: 60)
        
        let valuesStack = UIStackView(arrangedSubviews: [investmentValue, gainValue, annualReturnValue])
        valuesStack.axis = .vertical
        valuesStack.spacing = 2
        valuesStack.distribution = .fillEqually
        view.addSubview(valuesStack)
        valuesStack.anchor(top: stack.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 60)
        
        view.addSubview(percentualGainValue)
        percentualGainValue.centerY(inView: gainValue)
        percentualGainValue.anchor(right: gainValue.leftAnchor, paddingRight: 4)
        
    }
    
}

