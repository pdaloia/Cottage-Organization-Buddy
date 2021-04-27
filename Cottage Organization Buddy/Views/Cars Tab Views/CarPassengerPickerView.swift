//
//  CarPassengerPickerView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-25.
//

import UIKit

class CarPassengerPickerView: UIPickerView {

    var passengersToChooseFrom: [Attendee]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSelectedUserID() -> String {
        
        return passengersToChooseFrom![self.selectedRow(inComponent: 0)].firebaseUserID
        
    }
    
}

extension CarPassengerPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.passengersToChooseFrom!.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.passengersToChooseFrom![row].name
        
    }
    
}
