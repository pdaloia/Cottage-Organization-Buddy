//
//  RequestCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-01-31.
//

import UIKit

class RequestCell: UICollectionViewCell {
    
    //the cell's request model
    var request: RequestProtocol?
    
    //the cells objects
    var requestLabel = UILabel()
    var acceptButton = UIButton(type: .custom)
    var declineButton = UIButton(type: .custom)
    
    //delegates
    var buttonsDelegate: RequestCellButtonsDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(named: "Cottage Green")
        
        //add the contents and set its autolayout constraints
        setAutoLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //function to set the autolayout constraints for the cell's contents
    func setAutoLayoutConstraints() {
        
        //create the constraints for the cell's label
        self.addSubview(requestLabel)
        requestLabel.translatesAutoresizingMaskIntoConstraints = false
        requestLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        requestLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        requestLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        requestLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //create the stack view which will contain the accept and reject buttons
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .fill
        
        //add the buttons to the stack view
        buttonStackView.addArrangedSubview(acceptButton)
        buttonStackView.addArrangedSubview(declineButton)
        
        //add the button stack view to the cell
        self.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        //add the button images
        let addImage = UIImage(systemName: "checkmark.circle")
        acceptButton.imageView?.contentMode = .scaleAspectFit
        acceptButton.setImage(addImage, for: .normal)
        acceptButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        acceptButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        let declineImage = UIImage(systemName: "xmark.octagon")
        declineButton.imageView?.contentMode = .scaleAspectFit
        declineButton.setImage(declineImage, for: .normal)
        declineButton.addTarget(self, action: #selector(declineButtonClicked), for: .touchUpInside)
        
                        
    }

    //function to set the cell's dynamic objects like the label
    func setupRequestLabel() {
        
        requestLabel.textAlignment = .center
        requestLabel.text = request?.requester.name
        
    }
    
    @objc func addButtonClicked() {
        buttonsDelegate?.acceptButtonClicked(request: request!)
    }
    
    @objc func declineButtonClicked() {
        buttonsDelegate?.declineButtonClicked(request: request!)
    }
    
}

protocol RequestCellButtonsDelegate: class {
    
    func acceptButtonClicked(request: RequestProtocol)
    
    func declineButtonClicked(request: RequestProtocol)
    
}
