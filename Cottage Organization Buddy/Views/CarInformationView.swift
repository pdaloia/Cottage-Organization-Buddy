//
//  CarInformationView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-24.
//

import UIKit

class CarInformationView: UIView {
    
    //model
    var currentlySelectedCarModel: Car?
    
    //variable to see if a cell has not been selected yet
    var cellWasSelected: Bool = false
    
    //initial label
    var initialLabelMessage = UILabel()
    
    //display labels
    var driverDisplayNameLabel = UILabel()
    var passengersDisplayNamesLabel = UILabel()
    var seatsRemainingDisplayValueLabel = UILabel()
    
    //value labels
    var driverDisplayName = UILabel()
    var passengersDisplayNames = UILabel()
    var seatsRemainingDisplayValue = UILabel()
    
    //stack views
    var labelStackView = UIStackView()
    var dataStackView = UIStackView()
    var tableStackView = UIStackView()
    
    //initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViewInitialMessage() {
        
        //set the initial label's message
        initialLabelMessage.text = "Select a car to view the car's information!"
        
        //add the initial label to the view
        self.addSubview(initialLabelMessage)
        
        //set the autolayout constraints
        initialLabelMessage.translatesAutoresizingMaskIntoConstraints = false
        initialLabelMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        initialLabelMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        initialLabelMessage.adjustsFontSizeToFitWidth = true
        
    }
    
    func displayInformationAfterCellSelection() {
        
        //if a cell has not been selected yet, remove the initial label and initialize information labels
        if self.cellWasSelected == false {
            initialLabelMessage.removeFromSuperview()
            initializeDataInformationLabels()
            initializeStackViews()
            self.cellWasSelected = true
            return
        }
        //if cell has already been selected before this, just update the information labels
        else {
            updateCarInformation()
            return
        }
        
    }
    
    func initializeDataInformationLabels() {
        
        //get the required information from the selected cell
        let driverName = currentlySelectedCarModel!.driver.name
        let passengerNames = currentlySelectedCarModel!.returnPassengersNames()
        let remainingSeats = String(currentlySelectedCarModel!.calculateRemainingSeats())
        
        //create the text labels
        self.driverDisplayNameLabel.text = "Driver Name:"
        self.passengersDisplayNamesLabel.text = "Passengers in car:"
        self.seatsRemainingDisplayValueLabel.text = "Seats remaining:"
        
        //create the information labels
        self.driverDisplayName.text = driverName
        self.passengersDisplayNames.text = passengerNames
        self.seatsRemainingDisplayValue.text = remainingSeats
        
    }
    
    func initializeStackViews() {
        
        //set the label stack view and add it's labels
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.addArrangedSubview(driverDisplayNameLabel)
        labelStackView.addArrangedSubview(passengersDisplayNamesLabel)
        labelStackView.addArrangedSubview(seatsRemainingDisplayValueLabel)
        
        //set the data stack view and add it's data
        dataStackView.axis = .vertical
        dataStackView.distribution = .fillEqually
        dataStackView.addArrangedSubview(driverDisplayName)
        dataStackView.addArrangedSubview(passengersDisplayNames)
        dataStackView.addArrangedSubview(seatsRemainingDisplayValue)
        
        //set the table stack view and add the two stack views to it
        tableStackView.axis = .horizontal
        tableStackView.distribution = .fillEqually
        tableStackView.addArrangedSubview(labelStackView)
        tableStackView.addArrangedSubview(dataStackView)
        
        //add the table stack view to this view and set its constraints
        self.addSubview(tableStackView)
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        tableStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        tableStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        
    }
    
    func updateCarInformation() {
        
        let driverName = currentlySelectedCarModel!.driver.name
        let passengerNames = currentlySelectedCarModel!.returnPassengersNames()
        let remainingSeats = String(currentlySelectedCarModel!.calculateRemainingSeats())
        
        self.driverDisplayName.text = driverName
        self.passengersDisplayNames.text = passengerNames
        self.seatsRemainingDisplayValue.text = remainingSeats
        
    }

}
