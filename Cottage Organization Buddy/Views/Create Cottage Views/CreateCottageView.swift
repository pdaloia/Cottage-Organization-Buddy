//
//  CreateCottageView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-04.
//

import UIKit

class CreateCottageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeViewInputs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeViewInputs() {
        
        //Cottage name text field
        let nameInput = UITextField()
        nameInput.placeholder = "Enter the name of your cottage"
        self.addSubview(nameInput)
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        nameInput.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        nameInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        nameInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        //Cottage address text field
        let addressInput = UITextField()
        addressInput.placeholder = "Address of cottage"
        self.addSubview(addressInput)
        addressInput.translatesAutoresizingMaskIntoConstraints = false
        addressInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor).isActive = true
        addressInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        addressInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        
        //Cottage start date field
        let startDateInput = UIDatePicker()
        self.addSubview(startDateInput)
        startDateInput.translatesAutoresizingMaskIntoConstraints = false
        startDateInput.topAnchor.constraint(equalTo: addressInput.bottomAnchor).isActive = true
        startDateInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        startDateInput.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive =  true
        
        //Cottage end date field
        let endDateInput = UIDatePicker()
        self.addSubview(endDateInput)
        endDateInput.translatesAutoresizingMaskIntoConstraints = false
        endDateInput.topAnchor.constraint(equalTo: addressInput.bottomAnchor).isActive = true
        endDateInput.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        endDateInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive =  true
        
    }
    
}
