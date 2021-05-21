//
//  CreateCottageViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-04.
//

import UIKit
import FirebaseAuth

class CreateCottageViewController: UIViewController {
    
    var createCottageDelegate: CreateCottageVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Cottage"
        self.view.backgroundColor = .systemBackground
        
        initializeViewController()
    }
    
    func initializeViewController() {
        
        let createCottageView = CreateCottageView()
        createCottageView.createCottageViewDelegate = self
        self.view.addSubview(createCottageView)
        createCottageView.translatesAutoresizingMaskIntoConstraints = false
        createCottageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        createCottageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        createCottageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        createCottageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.view.addSubview(createCottageView)
        
    }

}

extension CreateCottageViewController: CreateCottageViewDelegate {
    
    func validateInputs(cottageName: String, cottageAddress: String, startDate: Date, endDate: Date) -> Bool {
        
        //name validation
        if cottageName == "" {
            ToastMessageDisplayer.showToast(controller: self, message: "Cottage name can't be empty", seconds: 2)
            return false
        }
        
        //address validation
        if cottageAddress == "" {
            ToastMessageDisplayer.showToast(controller: self, message: "Cottage address can't be empty", seconds: 2)
            return false
        }
        
        //end date before start date
        if endDate < startDate {
            ToastMessageDisplayer.showToast(controller: self, message: "Start date must be before end date", seconds: 2)
            return false
        }
        
        //end date before current date
        if endDate.timeIntervalSinceNow.sign == .minus {
            ToastMessageDisplayer.showToast(controller: self, message: "End date can't be before current time", seconds: 2)
            return false
        }
        
        return true
        
    }
    
    func uploadCottage(cottageName: String, cottageAddress: String, startDate: Date, endDate: Date) {
        
        let firestoreService = FirestoreServices()
        
        //date formatting
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateFormatted = dateFormatter.string(from: startDate)
        let endDateFormatted = dateFormatter.string(from: endDate)
        
        //create the spinner
        let spinner = UIActivityIndicatorView(style: .large)
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(spinner)
        spinner.startAnimating()
        
        //sending info to the firestore
        firestoreService.createCottage(name: cottageName, address: cottageAddress, startDate: startDateFormatted, endDate: endDateFormatted, userID: Auth.auth().currentUser!.uid, organiserName: Auth.auth().currentUser!.displayName!) { cottageID in
            
            //if there is a valid cottage id get the cottage using the service and present it
            if let id = cottageID {
                firestoreService.get(cottage: id) { model in
                    
                    spinner.stopAnimating()                    
                    self.createCottageDelegate?.created(cottage: model!)
                    
                }
            }
            else {
                spinner.stopAnimating()
                ToastMessageDisplayer.showToast(controller: self, message: "Error creating cottage", seconds: 2)
            }
            
        }
        
    }
    
}

protocol CreateCottageVCDelegate {
    
    func created(cottage: CottageTrip)
    
}
