//
//  AddGroceryView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-16.
//

import UIKit

class AddGroceryView: UIView {
    
    weak var uploadGroceryDelegate: AddGroceryDelegate?
    
    //create the text input fields
    private let groceryNameInput = UITextField()
    private let pricePerGroceryInput = UITextField()
    private let quantityOfGroceryInput = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = .systemBackground
        
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        
        //create the add button
        let addButton = UIButton()
        addButton.setTitleColor(.blue, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
        
        //configure input boxes
        groceryNameInput.placeholder = "Enter name of grocery"
        groceryNameInput.backgroundColor = .green
        groceryNameInput.borderStyle = .roundedRect
        pricePerGroceryInput.placeholder = "Enter price per item"
        pricePerGroceryInput.backgroundColor = .green
        pricePerGroceryInput.borderStyle = .roundedRect
        pricePerGroceryInput.keyboardType = .decimalPad
        quantityOfGroceryInput.placeholder = "Enter quantity of grocery"
        quantityOfGroceryInput.backgroundColor = .green
        quantityOfGroceryInput.borderStyle = .roundedRect
        quantityOfGroceryInput.keyboardType = .decimalPad
        
        //create the stack view which will contain all text fields
        let textFieldStackView = UIStackView()
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .equalSpacing
        textFieldStackView.alignment = .fill
        textFieldStackView.addArrangedSubview(groceryNameInput)
        textFieldStackView.addArrangedSubview(pricePerGroceryInput)
        textFieldStackView.addArrangedSubview(quantityOfGroceryInput)
        
        //add the stack view to the view and set its constraints
        self.addSubview(textFieldStackView)
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        textFieldStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        textFieldStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        textFieldStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        //add the add button below the stack view
        self.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func addButtonPressed(sender: UIButton!) {
        
        let groceryName: String = groceryNameInput.text!
        let groceryPrice: Double = Double(pricePerGroceryInput.text!)!
        let groceryQuantity: Int = Int(quantityOfGroceryInput.text!)!
        
        let groceryToAdd = Grocery(productName: groceryName, price: groceryPrice, Quantity: groceryQuantity)
        
        if let del = self.uploadGroceryDelegate {
            del.uploadToVC(Grocery: groceryToAdd)
        }
        
    }
    
}

protocol AddGroceryDelegate: class {
    
    func uploadToVC(Grocery groceryInformation: Grocery)
    
}
