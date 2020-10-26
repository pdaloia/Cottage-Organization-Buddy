//
//  CarInformationView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-24.
//

import UIKit

class CarInformationView: UIView {
    
    @IBOutlet weak var driverDisplayName: UILabel!
    @IBOutlet weak var passengersDisplayNames: UILabel!
    @IBOutlet weak var seatsRemainingDisplayValue: UILabel!
    @IBOutlet weak var initialLabelMessage : UILabel!
    
    var cellWasSelected: Bool = false
    
    var currentlySelectedCarModel: Car?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        
        let initialLabel = UILabel()
        initialLabelMessage = initialLabel
        initialLabelMessage.text = "Select a car to view the car's information!"
        
        self.addSubview(initialLabelMessage)
        
        initialLabelMessage.translatesAutoresizingMaskIntoConstraints = false
        initialLabelMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        initialLabelMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        initialLabelMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        initialLabelMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        initialLabelMessage.adjustsFontSizeToFitWidth = true
        
    }
    
    func displayInformation() {
        
        if self.cellWasSelected == false {
            initialLabelMessage.removeFromSuperview()
            initializeInformationLabels()
            self.cellWasSelected = true
            return
        }
        else {
            updateCarInformation()
            return
        }
        
    }
    
    func initializeInformationLabels() {
        
        let driverName = currentlySelectedCarModel!.driver.name
        let passengerNames = currentlySelectedCarModel!.returnPassengersNames()
        let remainingSeats = String(currentlySelectedCarModel!.calculateRemainingSeats())
        
        let initialDriverLabel = UILabel()
        self.driverDisplayName = initialDriverLabel
        
        let initialPassengersLabel = UILabel()
        self.passengersDisplayNames = initialPassengersLabel
        
        let initialSeatsRemainingLabel = UILabel()
        self.seatsRemainingDisplayValue = initialSeatsRemainingLabel
        
        self.driverDisplayName.text = "Driver Name: \(driverName)"
        self.passengersDisplayNames.text = "Passengers in car: \(passengerNames)"
        self.seatsRemainingDisplayValue.text = "Seats remaining: \(remainingSeats)"
        
        self.addSubview(self.driverDisplayName)
        self.addSubview(self.passengersDisplayNames)
        self.addSubview(self.seatsRemainingDisplayValue)
        
        self.driverDisplayName.translatesAutoresizingMaskIntoConstraints = false
        self.driverDisplayName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.driverDisplayName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.passengersDisplayNames.translatesAutoresizingMaskIntoConstraints = false
        self.passengersDisplayNames.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.passengersDisplayNames.topAnchor.constraint(equalTo: driverDisplayName.bottomAnchor).isActive = true
        
        self.seatsRemainingDisplayValue.translatesAutoresizingMaskIntoConstraints = false
        self.seatsRemainingDisplayValue.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.seatsRemainingDisplayValue.topAnchor.constraint(equalTo: passengersDisplayNames.bottomAnchor).isActive = true
        
    }
    
    func updateCarInformation() {
        
        let driverName = currentlySelectedCarModel!.driver.name
        let passengerNames = currentlySelectedCarModel!.returnPassengersNames()
        let remainingSeats = String(currentlySelectedCarModel!.calculateRemainingSeats())
        
        self.driverDisplayName.text = "Driver Name: \(driverName)"
        self.passengersDisplayNames.text = "Passengers in car: \(passengerNames)"
        self.seatsRemainingDisplayValue.text = "Seats remaining \(remainingSeats)"
        
    }

}
