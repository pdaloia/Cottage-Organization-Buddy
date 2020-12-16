//
//  AddGroceryView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-16.
//

import UIKit

class AddGroceryView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        
        //create the text input fields
        let groceryNameInput = UITextField()
        let pricePerGroceryInput = UITextField()
        let quantityOfGroceryInput = UITextField()
        
        //configure the traits of the text fields
        groceryNameInput.keyboardType = .default
        pricePerGroceryInput.keyboardType = .decimalPad
        quantityOfGroceryInput.keyboardType = .numberPad
        
        //set the first responder
        groceryNameInput.becomeFirstResponder()
        
        //add these text fields to the
        self.addSubview(groceryNameInput)
        self.addSubview(pricePerGroceryInput)
        self.addSubview(quantityOfGroceryInput)
        
        //create the constraints on the input fields
        groceryNameInput.translatesAutoresizingMaskIntoConstraints = false
        groceryNameInput.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        groceryNameInput.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        groceryNameInput.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        groceryNameInput.heightAnchor.constraint(equalToConstant: self.bounds.height/4).isActive = true
        groceryNameInput.layoutIfNeeded()
        
        pricePerGroceryInput.translatesAutoresizingMaskIntoConstraints = false
        pricePerGroceryInput.topAnchor.constraint(equalTo: groceryNameInput.bottomAnchor).isActive = true
        pricePerGroceryInput.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pricePerGroceryInput.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pricePerGroceryInput.heightAnchor.constraint(equalToConstant: self.bounds.height/4).isActive = true
        pricePerGroceryInput.layoutIfNeeded()
        
        quantityOfGroceryInput.translatesAutoresizingMaskIntoConstraints = false
        quantityOfGroceryInput.topAnchor.constraint(equalTo: pricePerGroceryInput.bottomAnchor).isActive = true
        quantityOfGroceryInput.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        quantityOfGroceryInput.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        quantityOfGroceryInput.heightAnchor.constraint(equalToConstant: self.bounds.height/4).isActive = true
        
    }
    
}
