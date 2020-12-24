//
//  AddDrinkViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-23.
//

import UIKit

class AddDrinkViewController: UIViewController {
    
    weak var drinkUploadDelegate: AddDrinkToModelDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        initializeViewController()
    }
    
    func initializeViewController() {
        
        let addDrinkView = AddDrinkView()
        addDrinkView.addDrinkDelegate = self
        
        self.view.addSubview(addDrinkView)
        addDrinkView.translatesAutoresizingMaskIntoConstraints = false
        addDrinkView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        addDrinkView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addDrinkView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addDrinkView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}

extension AddDrinkViewController: DrinkInformationDelegate {
    
    func validateDrinkInputs(drinkName: String) -> Bool {
        
        if drinkName.isEmpty {
            ToastMessageDisplayer.showToast(controller: self, message: "Enter a name", seconds: 1)
            return false
        }
        
        return true
        
    }
    
    func uploadDrinkInformation(drinkName: String, isAlcoholic: Bool, isForSharing: Bool) {
        
        let drinkToUpload = Drink(name: drinkName, isAlcoholic: isAlcoholic, forSharing: isForSharing)
        
        if let del = self.drinkUploadDelegate {
            del.upload(drink: drinkToUpload)
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

protocol AddDrinkToModelDelegate: class {
    
    func upload(drink: Drink)
    
}
