//
//  CreateCottageView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-04.
//

import UIKit

class CreateCottageView: UIView {
    
    var createCottageViewDelegate: CreateCottageViewDelegate?
    
    var nameInput: UITextField?
    var addressInput: UITextField?
    var startDateInput: UIDatePicker?
    var endDateInput: UIDatePicker?
    
    var cottageNameLabel: UILabel?
    var cottageAddressLabel: UILabel?
    var startDateLabel: UILabel?
    var endDateLabel: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeViewInputs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeViewInputs() {
        
        //cottage name label
        cottageNameLabel = UILabel()
        cottageNameLabel!.text = "Name of cottage"
        cottageNameLabel!.textColor = .green
        cottageNameLabel!.font = cottageNameLabel!.font.withSize(14)
        cottageNameLabel!.isHidden = true
        self.addSubview(cottageNameLabel!)
        cottageNameLabel!.translatesAutoresizingMaskIntoConstraints = false
        cottageNameLabel!.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        cottageNameLabel!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        //cottageNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        //Cottage name text field
        nameInput = UITextField()
        nameInput!.placeholder = "Enter the name of your cottage"
        nameInput!.addTarget(self, action: #selector(nameFieldEdited(sender:)), for: .editingChanged)
        self.addSubview(nameInput!)
        nameInput!.translatesAutoresizingMaskIntoConstraints = false
        nameInput!.topAnchor.constraint(equalTo: cottageNameLabel!.bottomAnchor).isActive = true
        nameInput!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        nameInput!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        //cottage address label
        cottageAddressLabel = UILabel()
        cottageAddressLabel!.text = "Address of cottage"
        cottageAddressLabel!.textColor = .green
        cottageAddressLabel!.font = cottageAddressLabel!.font.withSize(14)
        cottageAddressLabel!.isHidden = true
        self.addSubview(cottageAddressLabel!)
        cottageAddressLabel!.translatesAutoresizingMaskIntoConstraints = false
        cottageAddressLabel!.topAnchor.constraint(equalTo: nameInput!.bottomAnchor, constant: 10).isActive = true
        cottageAddressLabel!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        //Cottage address text field
        addressInput = UITextField()
        addressInput!.placeholder = "Address of cottage"
        addressInput!.addTarget(self, action: #selector(addressFieldEdited(sender:)), for: .editingChanged)
        self.addSubview(addressInput!)
        addressInput!.translatesAutoresizingMaskIntoConstraints = false
        addressInput!.topAnchor.constraint(equalTo: cottageAddressLabel!.bottomAnchor).isActive = true
        addressInput!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        addressInput!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        //start date label
        startDateLabel = UILabel()
        startDateLabel!.text = "Start Date"
        startDateLabel!.textColor = .green
        startDateLabel!.font = startDateLabel!.font.withSize(14)
        self.addSubview(startDateLabel!)
        startDateLabel!.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel!.topAnchor.constraint(equalTo: addressInput!.bottomAnchor, constant: 10).isActive = true
        startDateLabel!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        //Cottage start date field
        startDateInput = UIDatePicker()
        self.addSubview(startDateInput!)
        startDateInput!.translatesAutoresizingMaskIntoConstraints = false
        startDateInput!.topAnchor.constraint(equalTo: startDateLabel!.bottomAnchor).isActive = true
        startDateInput!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        startDateInput!.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive =  true
        
        //end date label
        //start date label
        endDateLabel = UILabel()
        endDateLabel!.text = "End Date"
        endDateLabel!.textColor = .green
        endDateLabel!.font = endDateLabel!.font.withSize(14)
        self.addSubview(endDateLabel!)
        endDateLabel!.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel!.topAnchor.constraint(equalTo: addressInput!.bottomAnchor, constant: 10).isActive = true
        endDateLabel!.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        
        //Cottage end date field
        endDateInput = UIDatePicker()
        self.addSubview(endDateInput!)
        endDateInput!.translatesAutoresizingMaskIntoConstraints = false
        endDateInput!.topAnchor.constraint(equalTo: endDateLabel!.bottomAnchor).isActive = true
        endDateInput!.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        endDateInput!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive =  true
        
        //create cottage button
        let createCottageButton = UIButton()
        createCottageButton.setTitle("Create Cottage", for: .normal)
        createCottageButton.setTitleColor(.systemBlue, for: .normal)
        createCottageButton.addTarget(self, action: #selector(createCottageButtonPressed), for: .touchUpInside)
        self.addSubview(createCottageButton)
        createCottageButton.translatesAutoresizingMaskIntoConstraints = false
        createCottageButton.topAnchor.constraint(equalTo: startDateInput!.bottomAnchor, constant: 20).isActive = true
        createCottageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func createCottageButtonPressed() {
        
        if let delegate = self.createCottageViewDelegate {
            let valid = delegate.validateInputs(cottageName: nameInput!.text ?? "", cottageAddress: addressInput!.text ?? "", startDate: startDateInput!.date, endDate: endDateInput!.date)
            if valid {
                delegate.uploadCottage(cottageName: nameInput!.text!, cottageAddress: addressInput!.text!, startDate: startDateInput!.date, endDate: endDateInput!.date)
            }
        }
        
    }
    
    @objc func nameFieldEdited(sender: UITextField) {
        
        if sender.text!.count > 1 {
            return
        }
        
        if sender.text != "" {
            UIView.transition(with: cottageNameLabel!, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.cottageNameLabel!.isHidden = false
                          })
        }
        else {
            UIView.transition(with: cottageNameLabel!, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.cottageNameLabel!.isHidden = true
                          })
        }
        
    }
    
    @objc func addressFieldEdited(sender: UITextField) {
        
        if sender.text!.count > 1 {
            return
        }
        
        if sender.text != "" {
            UIView.transition(with: cottageAddressLabel!, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.cottageAddressLabel!.isHidden = false
                          })
        }
        else {
            UIView.transition(with: cottageAddressLabel!, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.cottageAddressLabel!.isHidden = true
                          })
        }
        
    }
    
}

protocol CreateCottageViewDelegate: class {
    
    func validateInputs(cottageName: String, cottageAddress: String, startDate: Date, endDate: Date) -> Bool
    
    func uploadCottage(cottageName: String, cottageAddress: String, startDate: Date, endDate: Date)
    
}
