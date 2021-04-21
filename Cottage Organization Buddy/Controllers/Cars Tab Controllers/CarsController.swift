//
//  CarsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit
import Firebase

class CarsController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
    //views for the tab
    var carsCollectionView: CarsCollectionView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Cars"
        
        self.view.backgroundColor = .systemBackground
        
        createNavBarButtons()
        initializeCollectionView()
        
    }
    
    func initializeCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        carsCollectionView = CarsCollectionView(frame: self.view.frame, collectionViewLayout: layout, cellCount: cottageModel!.carsList.count)
        carsCollectionView?.cottageModel = cottageModel
        
        carsCollectionView?.register(CarCollectionViewCell.self, forCellWithReuseIdentifier: "CarCell")
        
        carsCollectionView?.collectionViewDelegate = self
        carsCollectionView?.delegate = carsCollectionView
        carsCollectionView?.dataSource = carsCollectionView
        
        carsCollectionView?.backgroundColor = .clear
        view.addSubview(carsCollectionView!)
        
        carsCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        carsCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        carsCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        carsCollectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }
    
    //this function creates the nav bar buttons as well as adds the proper ones to the nav bar
    func createNavBarButtons() {
        
        //add and remove buttons
        let addDriverButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addDriverButtonPressed))
        
        //get the currently logged in user
        var currentlyLoggedInUser: Attendee
        do {
            try currentlyLoggedInUser = UserService.GetLoggedInUser(model: cottageModel!)
        } catch UserError.cantFindUserError {
            ToastMessageDisplayer.showToast(controller: self, message: "Can not find your user in this trip", seconds: 2)
            return
        } catch {
            ToastMessageDisplayer.showToast(controller: self, message: "Unknown error, please restart app", seconds: 2)
            return
        }
        
        //check to see if the currently logged in user is a driver, then add the proper nav bar button
        let isADriver = cottageModel!.carsList.contains(where: { $0.driver === currentlyLoggedInUser })
        if !isADriver {
            self.navigationItem.rightBarButtonItems = [addDriverButton]
        }
        else {
            self.navigationItem.rightBarButtonItems = []
        }
        
        //create the request inbox navbar button
        let requestInbox = UIBarButtonItem(title: "Requests", style: .plain, target: self, action: #selector(requestInboxButtonPressed))
        self.navigationItem.rightBarButtonItems?.append(requestInbox)
        
    }
    
    @objc func requestInboxButtonPressed() {
        
        
        //load the request inbox list with the correct car requests
        let currentlyLoggedInUser: Attendee
        do {
            try currentlyLoggedInUser = UserService.GetLoggedInUser(model: self.cottageModel!)
        } catch UserError.cantFindUserError {
            ToastMessageDisplayer.showToast(controller: self, message: "Can not find your user in this trip", seconds: 2)
            return
        } catch {
            ToastMessageDisplayer.showToast(controller: self, message: "Unknown error, please restart app", seconds: 2)
            return
        }
        
        guard let requestList = self.cottageModel?.carsList.first(where: { $0.driver === currentlyLoggedInUser })?.requests else {
            return
        }
        
        //create the VC for the request inbox
        let requestInbox = RequestInboxViewController(requests: requestList)
        requestInbox.requestInboxDelegate = self
            
        //push the VC onto the stack
        self.navigationController?.pushViewController(requestInbox, animated: true)
        
    }
    
    //function for when the add button is pressed
    @objc func addDriverButtonPressed() {
        
        //create the add car VC, dependency inject it, and push it on the view stack
        let addDriverVC = AddCarViewController()
        addDriverVC.cottageModel = self.cottageModel
        addDriverVC.addDriverDelegate = self
        self.navigationController?.pushViewController(addDriverVC, animated: true)
        
    }
    
}

//extension of VC class to deal with delegation from other VCs/views
extension CarsController: AddDriverDelegate {
    
    //delegate to deal with uploading a car to the model
    func addCarToModel(numberOfPassengers: Int) {
        
        //we will first get the currently logged in user
        //for now we will hard code it to my user instance
        var loggedInUser = Attendee(name: "", firebaseUserID: "")
        
        do {
            try loggedInUser = UserService.GetLoggedInUser(model: cottageModel!)
        } catch UserError.cantFindUserError {
            ToastMessageDisplayer.showToast(controller: self, message: "Can not find your user account in this trip", seconds: 2)
            return
        } catch {
            ToastMessageDisplayer.showToast(controller: self, message: "Unexpected error, please restart the app", seconds: 2)
            return
        }
        
        //create a new car for the currently logged in user and add it to the list of cars in the cottage model. Also remove any request created by the new driver.
        let newCar = Car(driver: loggedInUser, numberOfSeats: numberOfPassengers, passengers: [], requests: [])
        cottageModel?.carsList.append(newCar)
        cottageModel?.removeAllCarRequests(for: loggedInUser)
                
        //reload the collection view and recreate the nav bar buttons
        self.carsCollectionView!.reloadData()
        self.createNavBarButtons()
        
        //remove the add car view and display a success message
        self.navigationController?.popViewController(animated: true)
        ToastMessageDisplayer.showToast(controller: self, message: "You have been added as a driver!", seconds: 2)
        
    }
    
}

extension CarsController: RequestInboxDelegate {
    
    func accept(request: RequestProtocol) {
        
        //we will first get the currently logged in user
        //for now we will hard code it to my user instance
        var loggedInUser = Attendee(name: "", firebaseUserID: "")
        
        do {
            try loggedInUser = UserService.GetLoggedInUser(model: cottageModel!)
        } catch UserError.cantFindUserError {
            ToastMessageDisplayer.showToast(controller: self, message: "Can not find your user account in this trip", seconds: 2)
            return
        } catch {
            ToastMessageDisplayer.showToast(controller: self, message: "Unexpected error, please restart the app", seconds: 2)
            return
        }
        
        //get the necessary information
        let currentCar = cottageModel?.carsList.last(where: { $0.driver === loggedInUser } )
        let attendeeToAddToPassengers = request.requester
        
        //add the requester to the passengers and remove the attendee's request
        currentCar?.passengers.append(attendeeToAddToPassengers)
        currentCar?.requests.removeAll(where: { $0.requester === attendeeToAddToPassengers } )
        
        //reload the collection view and recreate the nav bar buttons
        self.carsCollectionView!.reloadData()
        
        //recreate the nav bar buttons
        self.createNavBarButtons()
        
        //remove the add car view and display a success message
        self.navigationController?.popViewController(animated: true)
        ToastMessageDisplayer.showToast(controller: self, message: "Passenger accepted!", seconds: 2)
        
    }
    
    func decline(request: RequestProtocol) {
        
        //we will first get the currently logged in user
        //for now we will hard code it to my user instance
        var loggedInUser = Attendee(name: "", firebaseUserID: "")
        
        do {
            try loggedInUser = UserService.GetLoggedInUser(model: cottageModel!)
        } catch UserError.cantFindUserError {
            ToastMessageDisplayer.showToast(controller: self, message: "Can not find your user account in this trip", seconds: 2)
            return
        } catch {
            ToastMessageDisplayer.showToast(controller: self, message: "Unexpected error, please restart the app", seconds: 2)
            return
        }
        
        //get the necessary information
        let currentCar = cottageModel?.carsList.last(where: { $0.driver === loggedInUser } )
        let requestToDelete = request
        
        //add the requester to the passengers and remove the attendee's request
        currentCar?.requests.removeAll(where: { $0 === requestToDelete } )
        
        //reload the collection view and recreate the nav bar buttons
        self.carsCollectionView!.reloadData()
        
        //recreate the nav bar buttons
        self.createNavBarButtons()
        
        //remove the add car view and display a success message
        self.navigationController?.popViewController(animated: true)
        ToastMessageDisplayer.showToast(controller: self, message: "Passenger declined!", seconds: 2)
        
    }
    
}

extension CarsController: CarCollectionViewDelegate {
    
    func createRequest(for car: Car) {
        
        //we will first get the currently logged in user
        //for now we will hard code it to my user instance
        var loggedInUser = Attendee(name: "", firebaseUserID: "")
        
        do {
            try loggedInUser = UserService.GetLoggedInUser(model: cottageModel!)
        } catch UserError.cantFindUserError {
            ToastMessageDisplayer.showToast(controller: self, message: "Can not find your user account in this trip", seconds: 2)
            return
        } catch {
            ToastMessageDisplayer.showToast(controller: self, message: "Unexpected error, please restart the app", seconds: 2)
            return
        }
        
        //check if user can request a spot in this car
        let canRequestSpot = self.cottageModel?.checkIfAttendeeCanRequestCarSpot(loggedInUser, car)
        if canRequestSpot == false {
            ToastMessageDisplayer.showToast(controller: self, message: "Can't create request in this car", seconds: 2)
        }
        
        //confirm the user would like to create a request
        let confirmationAlert = UIAlertController(title: "Create Request", message: "Request a spot in " + car.driver.name + "'s car?", preferredStyle: .alert)
        confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            //do nothing
        }))
        confirmationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            car.createRequest(for: loggedInUser)
        }))
        
        present(confirmationAlert, animated: true, completion: nil)
        
    }
    
    
    func remove(passengerID: String, in car: Car) {
        
        print("Removing \(passengerID) in car driven by \(car.driver.name)")
        
    }
    
    func delete(car: Car) {
        
        if Auth.auth().currentUser!.uid != car.driver.firebaseUserID {
            ToastMessageDisplayer.showToast(controller: self, message: "Error deleting car", seconds: 2)
            return
        }
        else {
            
            let deleteCarAlert = UIAlertController(title: "Delete Car", message: "Are you sure you want to delete the car?", preferredStyle: .alert)
            
            let confirmDeleteAction = UIAlertAction(title: "Confirm", style: .destructive, handler: {_ in
                
                //get the firestore service and delete the car from firestore
                let firestoreService = FirestoreServices()
                firestoreService.deleteCar(drivenBy: Auth.auth().currentUser!.uid, in: self.cottageModel!.cottageID)
                
                //if successful delete the car from the model and reload the collection view
                self.cottageModel!.carsList.removeAll(where: { $0.driver.firebaseUserID == Auth.auth().currentUser!.uid })
                self.carsCollectionView!.isExpanded = Array(repeating: false, count: self.cottageModel!.carsList.count + 1)
                self.createNavBarButtons()
                self.carsCollectionView!.reloadData()
                                
            })
            
            let cancelDeleteAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
                //do nothing
            })
            
            deleteCarAlert.addAction(confirmDeleteAction)
            deleteCarAlert.addAction(cancelDeleteAction)
            
            present(deleteCarAlert, animated: true, completion: nil)
            
        }
        
    }
    
}
