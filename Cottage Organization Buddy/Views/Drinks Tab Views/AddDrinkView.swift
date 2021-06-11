//
//  AddDrinkView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-23.
//

import UIKit

class AddDrinkView: UIView {
    
    //MARK: - Properties
    
    weak var addDrinkDelegate: DrinkInformationDelegate?
    
    //MARK: - Views
    
    let drinkNameTextField: UITextField = {
        let drinkNameTextField = UITextField()
        drinkNameTextField.placeholder = "Enter name of drink"
        drinkNameTextField.addTarget(self, action: #selector(nameFieldEdited(sender:)), for: .editingChanged)
        return drinkNameTextField
    }()
    
    let drinkNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of drink"
        label.textColor = UIColor(named: "Cottage Dark Green")
        label.font = label.font.withSize(14)
        label.isHidden = true
        return label
    }()
    
    let isForSharingSwitch: UISwitch = {
        let isForSharingSwitch = UISwitch()
        return isForSharingSwitch
    }()
    
    let isForSharingLabel: UILabel = {
        let isForSharingLabel = UILabel()
        isForSharingLabel.text = "Is this drink for sharing?"
        return isForSharingLabel
    }()
    
    let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitleColor(.blue, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
        return addButton
    }()
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func initializeView() {
        
        //add the subviews
        self.addSubview(drinkNameLabel)
        self.addSubview(drinkNameTextField)
        self.addSubview(isForSharingLabel)
        self.addSubview(isForSharingSwitch)
        self.addSubview(addButton)
        
        //create the constraints
        
        drinkNameLabel.translatesAutoresizingMaskIntoConstraints = false
        drinkNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        drinkNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        drinkNameTextField.translatesAutoresizingMaskIntoConstraints = false
        drinkNameTextField.topAnchor.constraint(equalTo: self.drinkNameLabel.bottomAnchor).isActive = true
        drinkNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        drinkNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        isForSharingLabel.translatesAutoresizingMaskIntoConstraints = false
        isForSharingLabel.topAnchor.constraint(equalTo: drinkNameTextField.bottomAnchor, constant: 20).isActive = true
        isForSharingLabel.heightAnchor.constraint(equalToConstant: 31).isActive = true
        isForSharingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        isForSharingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        
        isForSharingSwitch.translatesAutoresizingMaskIntoConstraints = false
        isForSharingSwitch.topAnchor.constraint(equalTo: drinkNameTextField.bottomAnchor, constant: 20).isActive = true
        isForSharingSwitch.leadingAnchor.constraint(equalTo: isForSharingLabel.trailingAnchor).isActive = true
        isForSharingSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: isForSharingLabel.bottomAnchor, constant: 10).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func addButtonPressed(sender: UIButton!) {
        
        let drinkName = drinkNameTextField.text ?? ""
        
        var validated: Bool = false
        if let del = self.addDrinkDelegate {
            validated = del.validateDrinkInputs(drinkName: drinkName)
        }
        
        if validated == false {
            //break
            return
        }
     
        if let del = self.addDrinkDelegate {
            del.uploadDrinkInformation(drinkName: drinkName, isAlcoholic: false, isForSharing: isForSharingSwitch.isOn)
        }
        
    }
    
    @objc func nameFieldEdited(sender: UITextField) {
        
        if sender.text!.count > 1 {
            return
        }
        
        if sender.text != "" {
            UIView.transition(with: drinkNameLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.drinkNameLabel.isHidden = false
                          })
        }
        else {
            UIView.transition(with: drinkNameLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.drinkNameLabel.isHidden = true
                          })
        }
        
    }
    
}

protocol DrinkInformationDelegate: class {
    
    func uploadDrinkInformation(drinkName: String, isAlcoholic: Bool, isForSharing: Bool)
    
    func validateDrinkInputs(drinkName: String) -> Bool
    
}
