//
//  AddGroceryView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-16.
//

import UIKit

class AddGroceryView: UIView {
    
    //MARK: - Properties
    
    weak var uploadGroceryDelegate: AddGroceryDelegate?
    
    //MARK: - Views
    
    private let groceryNameLabel: UILabel = {
        let groceryNameLabel = UILabel()
        groceryNameLabel.text = "Name"
        groceryNameLabel.textColor = .green
        groceryNameLabel.font = groceryNameLabel.font.withSize(14)
        groceryNameLabel.isHidden = true
        return groceryNameLabel
    }()
    
    private let groceryNameInput: UITextField = {
        let groceryNameInput = UITextField()
        groceryNameInput.placeholder = "Enter name of grocery"
        groceryNameInput.addTarget(self, action: #selector(groceryNameFieldEdited(sender:)), for: .editingChanged)
        
        //create the toolbar
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonToolbarButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        groceryNameInput.inputAccessoryView = toolbar
        
        return groceryNameInput
    }()
    
    private let pricePerGroceryLabel: UILabel = {
        let pricePerGroceryLabel = UILabel()
        pricePerGroceryLabel.text = "Price"
        pricePerGroceryLabel.textColor = .green
        pricePerGroceryLabel.font = pricePerGroceryLabel.font.withSize(14)
        pricePerGroceryLabel.isHidden = true
        return pricePerGroceryLabel
    }()
    
    private let pricePerGroceryInput: UITextField = {
        let pricePerGroceryInput = UITextField()
        pricePerGroceryInput.placeholder = "Enter price per item"
        pricePerGroceryInput.keyboardType = .decimalPad
        pricePerGroceryInput.addTarget(self, action: #selector(groceryPriceFieldEdited(sender:)), for: .editingChanged)
        
        //create the toolbar
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonToolbarButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        pricePerGroceryInput.inputAccessoryView = toolbar
        
        return pricePerGroceryInput
    }()
    
    private let quantityOfGroceryLabel: UILabel = {
        let quantityOfGroceryLabel = UILabel()
        quantityOfGroceryLabel.text = "Quantity"
        quantityOfGroceryLabel.textColor = .green
        quantityOfGroceryLabel.font = quantityOfGroceryLabel.font.withSize(14)
        quantityOfGroceryLabel.isHidden = true
        return quantityOfGroceryLabel
    }()
    
    private let quantityOfGroceryInput: UITextField = {
        let quantityOfGroceryInput = UITextField()
        quantityOfGroceryInput.placeholder = "Enter quantity of grocery"
        quantityOfGroceryInput.keyboardType = .numberPad
        quantityOfGroceryInput.addTarget(self, action: #selector(groceryQuantityFieldEdited(sender:)), for: .editingChanged)
        
        //create the toolbar
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonToolbarButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        quantityOfGroceryInput.inputAccessoryView = toolbar
        
        return quantityOfGroceryInput
    }()
    
    private let attendeePickerLabel: UILabel = {
        let attendeePickerLabel = UILabel()
        attendeePickerLabel.text = "Assign grocery to user"
        attendeePickerLabel.textColor = .green
        attendeePickerLabel.font = attendeePickerLabel.font.withSize(14)
        //attendeePickerLabel.isHidden = true
        return attendeePickerLabel
    }()
    
    private let attendeePickerInput: UITextField = {
        let attendeePickerInput = UITextField()
        attendeePickerInput.placeholder = "Assign this grocery to a user"
        attendeePickerInput.text = "Unassigned"
        attendeePickerInput.tintColor = .clear
        attendeePickerInput.autocorrectionType = .no
        
        //create the toolbar
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonToolbarButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        attendeePickerInput.inputAccessoryView = toolbar
        
        return attendeePickerInput
    }()
    
    private let attendeePicker: UIPickerView = {
        let attendeePicker = UIPickerView()
        return attendeePicker
    }()
    
    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitleColor(.blue, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
        return addButton
    }()
    
    //attendees list to display in picker
    var attendeesToPick: [Attendee] = []

    //MARK: - Lifecycle and Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        self.attendeePickerInput.delegate = self

        self.addGestureRecognizer(tap)
        
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.endEditing(true)
    }
    
    func initializeView() {
        
        //setup the picker
        attendeePicker.delegate = self
        attendeePicker.dataSource = self
        attendeePickerInput.inputView = attendeePicker
        
        //add the subviews
        self.addSubview(groceryNameLabel)
        self.addSubview(groceryNameInput)
        self.addSubview(pricePerGroceryLabel)
        self.addSubview(pricePerGroceryInput)
        self.addSubview(quantityOfGroceryLabel)
        self.addSubview(quantityOfGroceryInput)
        self.addSubview(attendeePickerLabel)
        self.addSubview(attendeePickerInput)
        self.addSubview(addButton)
        
        //create the constraints
        groceryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        groceryNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        groceryNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        groceryNameInput.translatesAutoresizingMaskIntoConstraints = false
        groceryNameInput.topAnchor.constraint(equalTo: groceryNameLabel.bottomAnchor).isActive = true
        groceryNameInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        groceryNameInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        pricePerGroceryLabel.translatesAutoresizingMaskIntoConstraints = false
        pricePerGroceryLabel.topAnchor.constraint(equalTo: groceryNameInput.bottomAnchor, constant: 10).isActive = true
        pricePerGroceryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        pricePerGroceryInput.translatesAutoresizingMaskIntoConstraints = false
        pricePerGroceryInput.topAnchor.constraint(equalTo: pricePerGroceryLabel.bottomAnchor).isActive = true
        pricePerGroceryInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        pricePerGroceryInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        quantityOfGroceryLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityOfGroceryLabel.topAnchor.constraint(equalTo: pricePerGroceryInput.bottomAnchor, constant: 10).isActive = true
        quantityOfGroceryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        quantityOfGroceryInput.translatesAutoresizingMaskIntoConstraints = false
        quantityOfGroceryInput.topAnchor.constraint(equalTo: quantityOfGroceryLabel.bottomAnchor).isActive = true
        quantityOfGroceryInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        quantityOfGroceryInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        attendeePickerLabel.translatesAutoresizingMaskIntoConstraints = false
        attendeePickerLabel.topAnchor.constraint(equalTo: quantityOfGroceryInput.bottomAnchor, constant: 10).isActive = true
        attendeePickerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        attendeePickerInput.translatesAutoresizingMaskIntoConstraints = false
        attendeePickerInput.topAnchor.constraint(equalTo: attendeePickerLabel.bottomAnchor).isActive = true
        attendeePickerInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        attendeePickerInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: attendeePickerInput.bottomAnchor, constant: 10).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func groceryNameFieldEdited(sender: UITextField) {
        
        if sender.text!.count > 1 {
            return
        }
        
        if sender.text != "" {
            UIView.transition(with: groceryNameLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.groceryNameLabel.isHidden = false
                          })
        }
        else {
            UIView.transition(with: groceryNameLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.groceryNameLabel.isHidden = true
                          })
        }
        
    }
    
    @objc func groceryPriceFieldEdited(sender: UITextField) {
        
        if sender.text!.count > 1 {
            return
        }
        
        if sender.text != "" {
            UIView.transition(with: pricePerGroceryLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.pricePerGroceryLabel.isHidden = false
                          })
        }
        else {
            UIView.transition(with: pricePerGroceryLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.pricePerGroceryLabel.isHidden = true
                          })
        }
        
    }
    
    @objc func groceryQuantityFieldEdited(sender: UITextField) {
        
        if sender.text!.count > 1 {
            return
        }
        
        if sender.text != "" {
            UIView.transition(with: quantityOfGroceryLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.quantityOfGroceryLabel.isHidden = false
                          })
        }
        else {
            UIView.transition(with: quantityOfGroceryLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.quantityOfGroceryLabel.isHidden = true
                          })
        }
        
    }
    
    @objc func doneButtonToolbarButtonPressed() {
        self.groceryNameInput.endEditing(true)
        self.pricePerGroceryInput.endEditing(true)
        self.quantityOfGroceryInput.endEditing(true)
        self.attendeePickerInput.endEditing(true)
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
        
        let groceryToAdd = Grocery(productName: groceryName, price: groceryPrice, quantity: groceryQuantity, assignedTo: assignedUserID)
        
        if let del = self.uploadGroceryDelegate {
            del.uploadToVC(Grocery: groceryToAdd, for: assignedUserID)
        }
        
    }
    
}

extension AddGroceryView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - PickerView Delegate and Data Source
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                
        if row == 0 {
            attendeePickerInput.text = "Unassigned"
        }
        else {
            attendeePickerInput.text = attendeesToPick[row - 1].name
        }
        
    }
    
}

extension AddGroceryView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
}

protocol AddGroceryDelegate: class {
    
    //MARK: - Add Grocery Protocol
    
    func uploadToVC(Grocery groceryInformation: Grocery, for user: String)
    
    func validateInputs(name: String, price: Double, quantity: Int) -> Bool
    
}
