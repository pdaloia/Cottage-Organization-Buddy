//
//  CarsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class CarsController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
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
    
    func createNavBarButtons() {
        
        let addDriverButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addDriverButtonPressed))
        let removeDriverButton = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeDriverButtonPressed))
        
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
        
        let isADriver = cottageModel?.carsList.contains(where: { $0.driver === currentlyLoggedInUser })
        
        if isADriver == true {
            self.navigationItem.rightBarButtonItem = removeDriverButton
        }
        else {
            self.navigationItem.rightBarButtonItem = addDriverButton
        }
        
    }
    
    @objc func addDriverButtonPressed() {
        
        let addDriverVC = AddCarViewController()
        addDriverVC.cottageModel = self.cottageModel
        addDriverVC.addDriverDelegate = self
        self.navigationController?.pushViewController(addDriverVC, animated: true)
        
    }
    
    @objc func removeDriverButtonPressed() {
        
        let removeAlert = UIAlertController(title: "Remove yourself as a driver?", message: "Are you sure?", preferredStyle: .alert)
        
        removeAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
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
            
            self.cottageModel?.carsList.removeAll(where: { $0.driver === currentlyLoggedInUser })
            self.carsCollectionView.reloadData()
            self.carInformationView.reloadCarInformationView()
            
            self.createNavBarButtons()
            
        }))
        
        removeAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            //do nothing
        }))
        
        present(removeAlert, animated: true, completion: nil)
        
    }
    
}

extension CarsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cottageModel!.carsList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as! CarCollectionViewCell
        
        //setup the cell with the information from the cottage model
        cell.cellsCarModel = cottageModel!.carsList[indexPath.item]
        cell.setup()
        
        return cell
        
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //retrieve the selected car cell
        let selectedCarCell = collectionView.cellForItem(at: indexPath) as! CarCollectionViewCell
        
        //inject the information view's car model as the selected cell's car model
        carInformationView.currentlySelectedCarModel = selectedCarCell.cellsCarModel
        
        carInformationView.displayInformationAfterCellSelection()
        
    }
    
}

extension CarsController: AddDriverDelegate {
    
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
        
        let newCar = Car(driver: loggedInUser, numberOfSeats: numberOfPassengers, passengers: [], requesters: [])
        
        cottageModel?.carsList.append(newCar)
                
        self.carsCollectionView.reloadData()
        self.createNavBarButtons()
        
        self.navigationController?.popViewController(animated: true)
        ToastMessageDisplayer.showToast(controller: self, message: "You have been added as a driver!", seconds: 2)
        
    }
    
}
