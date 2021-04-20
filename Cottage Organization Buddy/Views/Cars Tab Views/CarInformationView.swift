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
    
    init(carModel: Car) {
        self.init()
        
        currentlySelectedCarModel = carModel
        initializeDataInformationLabels()
        initializeStackViews()
        updateCarInformation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initializeDataInformationLabels() {
        
        //get the required information from the selected cell
        let driverName = currentlySelectedCarModel!.driver.name
        let passengerNames = currentlySelectedCarModel!.returnPassengersNames()
        let remainingSeats = String(currentlySelectedCarModel!.calculateRemainingSeats())
        
        //create the text labels
        self.driverDisplayNameLabel.text = "Driver Name:"
        self.passengersDisplayNamesLabel.text = "Passengers in car:"
        self.passengersDisplayNamesLabel.numberOfLines = 2
        self.seatsRemainingDisplayValueLabel.text = "Seats remaining:"
        
        //create the information labels
        self.driverDisplayName.text = driverName
        self.passengersDisplayNames.text = passengerNames
        self.passengersDisplayNames.numberOfLines = 2
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
        tableStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        tableStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        tableStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        tableStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
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
