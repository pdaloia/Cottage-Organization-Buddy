//
//  CarsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class CarsController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
    //views for the tab
    @IBOutlet weak var carsCollectionView: UICollectionView!
    @IBOutlet weak var carInformationView: CarInformationView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Cars"
        
        carsCollectionView.dataSource = self
        carsCollectionView.delegate = self
        
        createNavBarButtons()
        createCarInformationView()
        
    }
    
    //function we use to create the car information view, as well as set its constraints
    func createCarInformationView() {
        
        let newCarInformationView = CarInformationView()
        carInformationView = newCarInformationView
        
        //add the collection view to the view
        self.view.addSubview(carInformationView)
        
        //set the constraints for this colleciton view
        carInformationView.translatesAutoresizingMaskIntoConstraints = false
        carInformationView.topAnchor.constraint(equalTo: self.carsCollectionView.bottomAnchor).isActive = true
        carInformationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        carInformationView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        //Now that the information view has been added, setup the view
        carInformationView.setupViewInitialMessage()
        
    }
    
    //this function creates the nav bar buttons as well as adds the proper ones to the nav bar
    func createNavBarButtons() {
        
        //add and remove buttons
        let addDriverButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addDriverButtonPressed))
        let removeDriverButton = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeDriverButtonPressed))
        
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
        let isADriver = cottageModel?.carsList.contains(where: { $0.driver === currentlyLoggedInUser })
        if isADriver == true {
            self.navigationItem.rightBarButtonItems = [removeDriverButton]
        }
        else {
            self.navigationItem.rightBarButtonItems = [addDriverButton]
        }
        
        //create the request inbox navbar button
        let requestInbox = UIBarButtonItem(title: "Requests", style: .plain, target: self, action: #selector(requestInboxButtonPressed))
        self.navigationItem.rightBarButtonItems?.append(requestInbox)
        
    }
    
    @objc func requestInboxButtonPressed() {
        
        let requestInbox = RequestInboxViewController()
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
    
    //function for when the remove button is pressed
    @objc func removeDriverButtonPressed() {
        
        //create the alert for removing the driver
        let removeAlert = UIAlertController(title: "Remove yourself as a driver?", message: "Are you sure?", preferredStyle: .alert)
        
        //create the action for if the removal is confirmed
        removeAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            //get the currently logged in user
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
            
            //remove the car in which the driver is the currently logged in user (if it exists) and then reload the views
            self.cottageModel?.carsList.removeAll(where: { $0.driver === currentlyLoggedInUser })
            self.carsCollectionView.reloadData()
            self.carInformationView.reloadCarInformationView()
            
            //recreate the nav bar buttons
            self.createNavBarButtons()
            
        }))
        
        removeAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            //do nothing
        }))
        
        //present the confirmation pop-up
        present(removeAlert, animated: true, completion: nil)
        
    }
    
}

//extension to deal with necessary collection view data source/delegate functions
extension CarsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //number of items in section
    //since theres only one section, we return the count of cars
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cottageModel!.carsList.count
        
    }
    
    //cell for item at
    //we use our custom car collection view cell and dependency inject a car model into it
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as! CarCollectionViewCell
        
        //setup the cell with the information from the cottage model
        cell.cellsCarModel = cottageModel!.carsList[indexPath.item]
        cell.setup()
        
        return cell
        
    }
    
    //sizing function for the collection view cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //create the amount of desired rows
        let rows: CGFloat
        let columns: CGFloat
        switch(collectionView.numberOfItems(inSection: indexPath.section)) {
        case 0..<3:
            rows = 1
            columns = 1
        default:
            rows = 2
            columns = 2
            
        }
        
        //create and calculate the dimensions for the cell size
        let collectionViewHeight = collectionView.bounds.height
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenRows = (flowLayout.minimumLineSpacing * (rows - 1)) + flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
        let spaceBetweenCellsInRow = (flowLayout.minimumInteritemSpacing * (columns - 1)) + flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let adjustedHeight = collectionViewHeight - spaceBetweenRows
        let adjustedWidth = collectionViewWidth - spaceBetweenCellsInRow
        
        let height: CGFloat = floor(adjustedHeight / rows)
        let width: CGFloat = floor(adjustedWidth / rows)
        
        return CGSize(width: width, height: height)
        
    }
    
    //handling the seleciton of a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //retrieve the selected car cell
        let selectedCarCell = collectionView.cellForItem(at: indexPath) as! CarCollectionViewCell
        
        //inject the information view's car model as the selected cell's car model
        carInformationView.currentlySelectedCarModel = selectedCarCell.cellsCarModel
        
        carInformationView.displayInformationAfterCellSelection()
        
    }
    
}

//extension of VC class to deal with delegation from other VCs/views
extension CarsController: AddDriverDelegate {
    
    //delegate to deal with uploading a car to the model
    func addCarToModel(numberOfPassengers: Int) {
        
        //we will first get the currently logged in user
        //for now we will hard code it to my user instance
        var loggedInUser = Attendee(name: "")
        
        do {
            try loggedInUser = UserService.GetLoggedInUser(model: cottageModel!)
        } catch UserError.cantFindUserError {
            ToastMessageDisplayer.showToast(controller: self, message: "Can not find your user account in this trip", seconds: 2)
            return
        } catch {
            ToastMessageDisplayer.showToast(controller: self, message: "Unexpected error, please restart the app", seconds: 2)
            return
        }
        
        //create a new car for the currently logged in user and add it to the list of cars in the cottage model
        let newCar = Car(driver: loggedInUser, numberOfSeats: numberOfPassengers, passengers: [], requesters: [])
        cottageModel?.carsList.append(newCar)
                
        //reload the collection view and recreate the nav bar buttons
        self.carsCollectionView.reloadData()
        self.createNavBarButtons()
        
        //remove the add car view and display a success message
        self.navigationController?.popViewController(animated: true)
        ToastMessageDisplayer.showToast(controller: self, message: "You have been added as a driver!", seconds: 2)
        
    }
    
}
