//
//  BedInformationView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-02.
//

import UIKit

class BedInformationView: UIView {
    
    //stack views
    let labelStackView = UIStackView()
    let dataStackView = UIStackView()
    let tableStackView = UIStackView()
    
    //display labels
    let occupantsLabel = UILabel()
    
    //data labels
    let occupantNames = UILabel()
    
    func setupStackViews() {
        
        labelStackView.addSubview(occupantsLabel)
        
        dataStackView.addSubview(occupantNames)
        
        tableStackView.axis = .horizontal
        tableStackView.addSubview(labelStackView)
        tableStackView.addSubview(dataStackView)
        
    }

}
