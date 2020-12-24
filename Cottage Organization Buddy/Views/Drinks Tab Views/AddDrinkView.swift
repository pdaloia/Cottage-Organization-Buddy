//
//  AddDrinkView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-23.
//

import UIKit

class AddDrinkView: UIView {
    
    private let drinkNameTextField = UITextField()
    private let isAlcoholicSwitch = UISwitch()
    private let isForSharingSwitch = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        //configure the name text field
        drinkNameTextField.placeholder = "Enter name of drink"
        drinkNameTextField.backgroundColor = .green
        drinkNameTextField.borderStyle = .roundedRect
        
        //create the switch labels
        let isAlcoholicLabel = UILabel()
        isAlcoholicLabel.text = "Is this drink alcoholic?"
        let isForSharingLabel = UILabel()
        isForSharingLabel.text = "Is this drink for sharing?"
        
        //pair the switches and labels in stack views to place in view
        let isAlcoholicStack = UIStackView()
        isAlcoholicStack.axis = .horizontal
        isAlcoholicStack.alignment = .fill
        isAlcoholicStack.distribution = .fillEqually
        isAlcoholicStack.addArrangedSubview(isAlcoholicLabel)
        isAlcoholicStack.addArrangedSubview(isAlcoholicSwitch)
        
        let isForSharingStack = UIStackView()
        isForSharingStack.axis = .horizontal
        isForSharingStack.alignment = .fill
        isForSharingStack.distribution = .fillEqually
        isForSharingStack.addArrangedSubview(isForSharingLabel)
        isForSharingStack.addArrangedSubview(isForSharingSwitch)
        
        //add the contents to the view
        let allFieldsStack = UIStackView()
        allFieldsStack.axis = .vertical
        allFieldsStack.alignment = .fill
        allFieldsStack.distribution = .equalSpacing
        allFieldsStack.addArrangedSubview(drinkNameTextField)
        allFieldsStack.addArrangedSubview(isAlcoholicStack)
        allFieldsStack.addArrangedSubview(isForSharingStack)
        
        //add the full stack to the view
        self.addSubview(allFieldsStack)
        allFieldsStack.translatesAutoresizingMaskIntoConstraints = false
        allFieldsStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        allFieldsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        allFieldsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        allFieldsStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        //add the add button below the stack view
        self.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: allFieldsStack.bottomAnchor, constant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func addButtonPressed(sender: UIButton!) {
     
        print("adding drink")
        
    }
    
}
