//
//  AddCarView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-24.
//

import UIKit

class AddCarView: UIView {
    
    weak var addDriverDelegate: CarInformationDelegate?
        
    let numberOfAvailableSeatsInput = UITextField()

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
        
        //label for the view
        let addDriverLabel = UILabel()
        addDriverLabel.text = "Please fill out this information to add yourself as a driver to this trip"
        addDriverLabel.textAlignment = .center
        addDriverLabel.numberOfLines = 0
        addDriverLabel.lineBreakMode = .byWordWrapping
        
        //configure input boxes
        numberOfAvailableSeatsInput.placeholder = "Enter number of available seats"
        numberOfAvailableSeatsInput.backgroundColor = .green
        numberOfAvailableSeatsInput.borderStyle = .roundedRect
        numberOfAvailableSeatsInput.keyboardType = .numberPad
        
        //configure the overall stack view
        let overallStack = UIStackView()
        overallStack.axis = .vertical
        overallStack.alignment = .fill
        overallStack.distribution = .equalSpacing
        
        //add the views to the overall stack view
        overallStack.addArrangedSubview(addDriverLabel)
        overallStack.addArrangedSubview(numberOfAvailableSeatsInput)
        overallStack.addArrangedSubview(addButton)
        
        //add the stack to the view's content and set its constraints
        self.addSubview(overallStack)
        overallStack.translatesAutoresizingMaskIntoConstraints = false
        overallStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        overallStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        overallStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        overallStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    @objc func addButtonPressed(sender: UIButton!) {
        
        let numberOfPassengers: Int = Int(numberOfAvailableSeatsInput.text!) ?? 0
        
        var validated: Bool = false
        if let del = self.addDriverDelegate {
            validated = del.validateDriverInputs(numberOfPassengers: numberOfPassengers)
        }
        
        if validated == false {
            return
        }
        
        if let del = self.addDriverDelegate {
            del.sendDriverInfo(numberOfPassengers: numberOfPassengers)
        }
        
    }
    
}

protocol CarInformationDelegate: class {
    
    func sendDriverInfo(numberOfPassengers: Int)
    
    func validateDriverInputs(numberOfPassengers: Int) -> Bool
    
}
