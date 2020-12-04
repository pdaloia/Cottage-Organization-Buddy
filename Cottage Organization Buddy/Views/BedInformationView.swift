//
//  BedInformationView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-02.
//

import UIKit

class BedInformationView: UIView {
    
    //initial message
    let initialMessageLabel = UILabel()
    
    //variable to see if a cell has been selected yet
    var cellHasBeenSelected = false
    
    //model for the information to display
    var bedModelToDisplay: Bed?
    
    //stack views
    let labelStackView = UIStackView()
    let dataStackView = UIStackView()
    let tableStackView = UIStackView()
    
    //display labels
    let occupantsLabel = UILabel()
    
    //data labels
    let occupantNames = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func intializeView() {
        
        initialMessageLabel.text = "Select a bed to view its information"
        self.addSubview(initialMessageLabel)
        
        initialMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        initialMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        initialMessageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    func setupStackViews() {
        
        occupantsLabel.text = "Occupants:"
        occupantsLabel.textAlignment = .center
        labelStackView.addArrangedSubview(occupantsLabel)
        
        //occupantNames.textAlignment = .center
        dataStackView.addArrangedSubview(occupantNames)
        
        tableStackView.axis = .horizontal
        tableStackView.distribution = .fillEqually
        tableStackView.addArrangedSubview(labelStackView)
        tableStackView.addArrangedSubview(dataStackView)
        
        self.addSubview(tableStackView)
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
    }
    
    func updateBedInformationToDisplay() {
        
        //check to see if this is the first time a bed has been selected
        if cellHasBeenSelected == false {
            initialMessageLabel.removeFromSuperview()
            setupStackViews()
            self.cellHasBeenSelected = true
        }
        
        occupantNames.text = bedModelToDisplay?.returnOccupantNames()
        
    }

}
