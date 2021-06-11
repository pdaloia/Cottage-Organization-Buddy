//
//  AddCarViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-24.
//

import UIKit

class AddCarViewController: UIViewController {
    
    var cottageModel: CottageTrip?
    
    weak var addDriverDelegate: AddDriverDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Car"
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")

        initializeVC()
    }
    

    func initializeVC() {        
        
        //create the view
        let addDriverView = AddCarView()
        addDriverView.addDriverDelegate = self
        
        //add the view to the VC
        self.view.addSubview(addDriverView)
        
        //set the auto layout constraints
        addDriverView.translatesAutoresizingMaskIntoConstraints = false
        addDriverView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        addDriverView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        addDriverView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        addDriverView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3).isActive = true
        
    }

}

extension AddCarViewController: CarInformationDelegate {
    
    func sendDriverInfo(numberOfPassengers: Int) {
        
        addDriverDelegate?.addCarToModel(numberOfPassengers: numberOfPassengers)
        
    }
    
    func validateDriverInputs(numberOfPassengers: Int) -> Bool {
        
        if numberOfPassengers <= 0 {
            ToastMessageDisplayer.showToast(controller: self, message: "Number of passengers can not be 0 (or less)", seconds: 1)
            return false
        }
        
        return true
        
    }
    
}

protocol AddDriverDelegate: class {
    
    func addCarToModel(numberOfPassengers: Int)
    
}
