//
//  FirestoreServices.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-03-14.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreServices {
    
    init() {
        
    }
    
    func get(cottage: String, completionHandler: @escaping (CottageTrip?) -> ()) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the fields from the initial document and load them into the cottage model
        cottageRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                //create the cottage model to return
                let cottageModel: CottageTrip = CottageTrip()
                
                //get the subcollections of this document
                let attendeesCollection = cottageRef.collection("attendees")
                let carsCollection = cottageRef.collection("cars")
                let drinksCollection = cottageRef.collection("drinks")
                let groceriesCollection = cottageRef.collection("groceries")
                let roomsCollection = cottageRef.collection("rooms")
                
                //get the necessary trip information
                let tripName: String = document.get("tripName") as! String
                let organiserID: String = document.get("organiserID") as! String
                let organiserName: String = document.get("organiserName") as! String
                let address: String = document.get("address") as! String
                
                //date conversions
                let startDateString: String = document.get("startDate") as! String
                let endDateString: String = document.get("endDate") as! String
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let startDate: Date = formatter.date(from: startDateString)!
                let endDate: Date = formatter.date(from: endDateString)!
                
                //load them into the model
                cottageModel.tripName = tripName
                cottageModel.tripOrganiser = Attendee(name: organiserName, firebaseUserID: organiserID)
                cottageModel.startDate = startDate
                cottageModel.endDate = endDate
                cottageModel.address = address
                
                let group = DispatchGroup()
                
                //get the attendees
                group.enter()
                attendeesCollection.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                            print("Error getting documents: \(err)")
                    } else {
                        
                        //first get the attendees
                        print("attendees data")
                        for document in querySnapshot!.documents {
                            let attendeeToAdd = Attendee(name: document.get("name") as! String, firebaseUserID: document.documentID)
                            cottageModel.attendeesList.append(attendeeToAdd)
                        }
                        print("after attendees data")
                        
                        //get the cars
                        group.enter()
                        carsCollection.getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                    print("Error getting documents: \(err)")
                            } else {
                                print("car data")
                                for document in querySnapshot!.documents {
                                    //get the driver attendee model
                                    let driverID = document.documentID
                                    let driverAttendeeModel: Attendee? = cottageModel.attendeesList.first(where: { $0.firebaseUserID == driverID } )
                                    
                                    //get number of seats
                                    let numberOfSeats: Int = document.get("numberOfSeats") as! Int
                                    
                                    //get the passengers
                                    let passengerIDs = document.get("passengers") as! [String]
                                    var passengers: [Attendee] = []
                                    for passengerID in passengerIDs {
                                        let passenger: Attendee? = cottageModel.attendeesList.first(where: { $0.firebaseUserID == passengerID } )
                                        passengers.append(passenger!)
                                    }
                                    
                                    //get the requests
                                    let requesterIDs = document.get("requests") as! [String]
                                    var requests: [CarRequest] = []
                                    for requestID in requesterIDs {
                                        let requester: Attendee? = cottageModel.attendeesList.first(where: { $0.firebaseUserID == requestID } )
                                        let request = CarRequest(requester: requester!)
                                        requests.append(request)
                                    }
                                    
                                    let carToAdd = Car(driver: driverAttendeeModel!, numberOfSeats: numberOfSeats, passengers: passengers, requests: requests)
                                    
                                    cottageModel.carsList.append(carToAdd)
                                }
                            }
                            print("done car data")
                            group.leave()
                        }
                        
                        //get the drinks
                        group.enter()
                        drinksCollection.getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                    print("Error getting documents: \(err)")
                            } else {
                                //drink data manipulation
                                print("drink data")
                                
                                for document in querySnapshot!.documents {
                                    
                                    let drinkListUserID = document.documentID
                                    let drinkListAttendee: Attendee = cottageModel.attendeesList.first(where: { $0.firebaseUserID == drinkListUserID } )!
                                    
                                    var userDrinks: [Drink] = []
                                    
                                    let drinks = document.data()
                                    for (key, values) in drinks {
                                        let drinkName: String = key
                                        let drinkInfo: [Bool] = values as! [Bool]
                                        let isAlcoholic: Bool = drinkInfo[0]
                                        let isForSharing: Bool = drinkInfo[1]
                                        
                                        let drinkToAdd: Drink = Drink(name: drinkName, isAlcoholic: isAlcoholic, forSharing: isForSharing)
                                        userDrinks.append(drinkToAdd)
                                    }
                                    
                                    let currentUserDrinkList: PersonalDrinksList = PersonalDrinksList(person: drinkListAttendee, drinkNames: userDrinks)
                                    cottageModel.drinksList.append(currentUserDrinkList)
                                    
                                }
                            }
                            print("done drink data")
                            group.leave()
                        }
                        
                        //get the groceries
                        group.enter()
                        groceriesCollection.getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                    print("Error getting documents: \(err)")
                            } else {
                                //groceries data manipulation
                                print("groceries data")
                            }
                            print("done groceries data")
                            group.leave()
                        }
                        
                        //get the rooms/beds
                        group.enter()
                        roomsCollection.getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                    print("Error getting documents: \(err)")
                            } else {
                                //room/bed data manipulation
                                print("room data")
                            }
                            print("done room data")
                            group.leave()
                        }
                        
                    }
                    print("done attendees data")
                    group.leave()
                }
                
                //create the cars
                
                
                //return the cottage model to the completion handler only when all tasks are complete
                group.notify(queue: .main) {
                    print("notifying with completion handler")
                    completionHandler(cottageModel)
                }
                
            } else {
                print("Document does not exist")
                completionHandler(nil)
            }
            
        }
        
    }
    
}