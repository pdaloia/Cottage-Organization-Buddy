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
        
    }
    
    func displayInformation(fromCarCell selectedCarCell: CarCollectionViewCell) {
    
        
        
    }

}
