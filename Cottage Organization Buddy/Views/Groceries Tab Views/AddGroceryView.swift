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
    private let attendeePicker = UIPickerView()
    
    //attendees list to display in picker
    var attendeesToPick: [Attendee] = []

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
        quantityOfGroceryInput.keyboardType = .numberPad
        
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
        
        //create label for pickery view
        let attendeePickerLabel = UILabel()
        attendeePickerLabel.text = "Assign grocery to user"
        self.addSubview(attendeePickerLabel)
        attendeePickerLabel.translatesAutoresizingMaskIntoConstraints = false
        attendeePickerLabel.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 20).isActive = true
        attendeePickerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        attendeePickerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        //create the picker item
        attendeePicker.delegate = self
        attendeePicker.dataSource = self
        
        //add the pickery view to the view
        self.addSubview(attendeePicker)
        attendeePicker.translatesAutoresizingMaskIntoConstraints = false
        attendeePicker.topAnchor.constraint(equalTo: attendeePickerLabel.bottomAnchor).isActive = true
        attendeePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        attendeePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        //attendeePicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        //add the add button below the stack view
        self.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: attendeePicker.bottomAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func addButtonPressed(sender: UIButton!) {
        
        let groceryName: String = groceryNameInput.text ?? ""
        let groceryPrice: Double = Double(pricePerGroceryInput.text!) ?? 0
        let groceryQuantity: Int = Int(quantityOfGroceryInput.text!) ?? 0
        
        var assignedUserID = ""
        if attendeePicker.selectedRow(inComponent: 0) != 0 {
            assignedUserID = attendeesToPick[attendeePicker.selectedRow(inComponent: 0) - 1].firebaseUserID
        }
        
        var validated: Bool = false
        
        if let del = self.uploadGroceryDelegate {
            validated = del.validateInputs(name: groceryName, price: groceryPrice, quantity: groceryQuantity)
        }
        
        if validated == false {
            //break
            return
        }
        
        let groceryToAdd = Grocery(productName: groceryName, price: groceryPrice, quantity: groceryQuantity)
        
        if let del = self.uploadGroceryDelegate {
            del.uploadToVC(Grocery: groceryToAdd, for: assignedUserID)
        }
        
    }
    
}

extension AddGroceryView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return attendeesToPick.count + 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            return "Unassigned"
        }
        else {
            return attendeesToPick[row - 1].name
        }
        
    }
    
}

protocol AddGroceryDelegate: class {
    
    func uploadToVC(Grocery groceryInformation: Grocery, for user: String)
    
    func validateInputs(name: String, price: Double, quantity: Int) -> Bool
    
}
