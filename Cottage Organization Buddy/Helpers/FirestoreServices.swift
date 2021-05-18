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
    
    func checkForUserDocument(id: String, completionHandler: @escaping (Bool) -> ()) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the user collection
        let userDocRef = db.collection("users").document(id)
        
        userDocRef.getDocument() { (doc, error) in
            if let doc = doc, doc.exists{
                completionHandler(true)
            }
            else {
                completionHandler(false)
            }
        }
        
    }
    
    func sendInvite(to email: String, for cottageID: String, completionHandler: @escaping (String?) -> ()) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the user document
        let userDocRef = db.collection("users").whereField("email", isEqualTo: email)
        
        userDocRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler("Firestore Error")
            }
            else {
                //if the document is not found for this user email, they are not registered case
                if querySnapshot!.documents.count == 0 {
                    print("no documents found for this email")
                    completionHandler("Not Registered")
                }
                //case if there are two user documents with the same email for some reason, hopefully never happens but just in case
                else if querySnapshot!.documents.count > 1 {
                    print("more than one document found for this email")
                    completionHandler("More Than One User Document")
                }
                //if a single document with this email is found registered for the app
                else {
                    let document = querySnapshot!.documents[0]
                    let cottageIDs = document.data()["cottageIDs"] as? [String] ?? []
                    //case where the email document already has this cottage id accepted
                    if cottageIDs.contains(cottageID) {
                        print("user already in cottage")
                        completionHandler("Already In Cottage")
                    }
                    //case where we successfully invite the user 
                    else {
                        db.collection("users").document(document.documentID).updateData([
                            "invitedCottageIDs" : FieldValue.arrayUnion([cottageID])
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                                completionHandler(nil)
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    func createPendingInvites(for email: String, in cottageID: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the user document
        let uncreatedCollectionRef = db.collection("uncreated")
        
        //get the document for an uncreated user
        let uncreatedDoc = uncreatedCollectionRef.document(email)
        
        //update the document
        uncreatedDoc.setData([
            "pendingInvites" : FieldValue.arrayUnion([cottageID])
        ], merge: true)  { err in
            if let err = err {
                print("Error writing uncreated account document: \(err)")
            } else {
                print("Uncreated account document successfully written!")
            }
        }
        
    }
    
    func getInvitedCottages(for userID: String, completionHandler: @escaping ([CottageInfo]?) -> ()) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let usersCollectionRef = db.collection("users")
        let cottageCollectionRef = db.collection("cottages")
        
        //get the invited cottage IDs
        let userDoc = usersCollectionRef.document(userID)
        
        var invitedCottages: [CottageInfo] = []
        
        //get the user's invited cottages
        userDoc.getDocument() { document, error in
            
            if let document = document, document.exists {
                
                //get the cottage IDs of the user
                let invitedCottageIDs = document.get("invitedCottageIDs") as? [String] ?? []
                
                //create a dispatch group with a lock for each cottage ID
                let group = DispatchGroup()
                for _ in invitedCottageIDs {
                    group.enter()
                }
                
                //iterate over all IDs of user
                for id in invitedCottageIDs {
                    
                    //get the document in conttage collection
                    cottageCollectionRef.document(id).getDocument() { (document, error) in
                        if let document = document, document.exists {
                            print("Getting info for cottage: \(id)")
                            let cottageID = id
                            let cottageName: String = document.get("tripName") as! String
                            
                            let organizerDoc: DocumentReference = document.get("organizer") as! DocumentReference
                            organizerDoc.getDocument() { document, error in
                                if let document = document, document.exists {
                                    let organizerName = document.get("fullName") as! String
                                    let organizerID = document.documentID
                                    let cottageOrganizerModel = Attendee(name: organizerName, firebaseUserID: organizerID)
                                    let cottageInfo = CottageInfo(cottageID: cottageID, cottageName: cottageName, cottageOrganiser: cottageOrganizerModel)
                                    invitedCottages.append(cottageInfo)
                                    
                                    print("Done getting info for cottage: \(id)")
                                    group.leave()
                                }
                            }
                        }
                        else {
                            print("Document does not exist")
                            group.leave()
                        }
                    }
                    
                }
                
                //return the cottage info list to the completion handler only when all tasks are complete
                group.notify(queue: .main) {
                    print("notifying with completion handler")
                    completionHandler(invitedCottages)
                }
            }
            else {
                print("Document does not exist")
                completionHandler([])
            }
            
        }
        
    }
    
    func acceptInvite(for cottageID: String, userID: String, name: String) {
        
        //get the reference to the firestore
        let db = Firestore.firestore()
        
        //get the users and cottage collection references
        let usersCollection = db.collection("users")
        let cottagesCollection = db.collection("cottages")
        
        //remove the cottage id from the invited array and add it to the cottages array
        let userDoc = usersCollection.document(userID)
        userDoc.updateData([
            "invitedCottageIDs" : FieldValue.arrayRemove([cottageID]),
            "cottageIDs" : FieldValue.arrayUnion([cottageID])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        //add the user to the cottages attendees collection
        let cottageDoc = cottagesCollection.document(cottageID)
        let attendeesCollection = cottageDoc.collection("attendees")
        let attendeeRef: DocumentReference = db.document("users/\(userID)")
        attendeesCollection.document(userID).setData([
            "userDoc" : attendeeRef
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    func declineInvite(for cottageID: String, userID: String) {
        
        //get the reference to the firestore
        let db = Firestore.firestore()
        
        //get the users and cottage collection references
        let usersCollection = db.collection("users")
        
        //remove the cottage id from the invited array and add it to the cottages array
        let userDoc = usersCollection.document(userID)
        userDoc.updateData([
            "invitedCottageIDs" : FieldValue.arrayRemove([cottageID])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    func createUserDocument(for userID: String, email: String, firstName: String, lastName: String, fullName: String, completionHandler: @escaping (Bool) -> ()) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //dispatch group to wait for uncreated user doc check
        let uncreatedGroup = DispatchGroup()
        
        //check if there are pending invites for this email in the uncreated collection
        let uncreatedCollectionRef = db.collection("uncreated")
        let userUncreatedDoc = uncreatedCollectionRef.document(email)
        var userPendingInvites: [String] = []
        uncreatedGroup.enter()
        userUncreatedDoc.getDocument() { document, error in
            if let document = document, document.exists {
                userPendingInvites = document.get("pendingInvites") as! [String]
                userUncreatedDoc.delete()
            }
            else {
                userPendingInvites = []
            }
            uncreatedGroup.leave()
        }
        
        uncreatedGroup.notify(queue: .main) {
            
            //get the references to the user collection
            db.collection("users").document(userID).setData([
                "cottageIDs" : [],
                "invitedCottageIDs" : userPendingInvites,
                "email" : email,
                "firstName" : firstName,
                "fullName" : fullName,
                "lastName" : lastName
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completionHandler(false)
                } else {
                    print("Document successfully written!")
                    completionHandler(true)
                }
            }
            
        }
        
    }
    
    func getCottages(for userID: String, completionHandler: @escaping ([CottageInfo]) -> ()){
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the user collection
        let userRef = db.collection("users").document(userID)
        
        let cottagesRef = db.collection("cottages")
        
        //get the user document and get the data
        var userCottages: [CottageInfo] = []
        
        //get the user reference document
        userRef.getDocument() { (document, error) in
            if let document = document, document.exists {
                
                //get the cottage IDs of the user
                let userCottageIDs = document.get("cottageIDs") as! [String]
                
                //create a dispatch group with a lock for each cottage ID
                let group = DispatchGroup()
                for _ in userCottageIDs {
                    group.enter()
                }
                
                //iterate over all IDs of user
                for id in userCottageIDs {
                    
                    //get the document in conttage collection
                    cottagesRef.document(id).getDocument() { (document, error) in
                        if let document = document, document.exists {
                            print("Getting info for cottage: \(id)")
                            let cottageID = id
                            let cottageName: String = document.get("tripName") as! String
                            
                            let organizerDoc: DocumentReference = document.get("organizer") as! DocumentReference
                            organizerDoc.getDocument() { document, error in
                                if let document = document, document.exists {
                                    let organizerName = document.get("fullName") as! String
                                    let organizerID = document.documentID
                                    let cottageOrganizerModel = Attendee(name: organizerName, firebaseUserID: organizerID)
                                    let cottageInfo = CottageInfo(cottageID: cottageID, cottageName: cottageName, cottageOrganiser: cottageOrganizerModel)
                                    userCottages.append(cottageInfo)
                                    print("Done getting info for cottage: \(id)")
                                    group.leave()
                                }
                            }
                        }
                        else {
                            print("Document does not exist")
                            group.leave()
                        }
                    }
                    
                }
                
                //return the cottage info list to the completion handler only when all tasks are complete
                group.notify(queue: .main) {
                    print("notifying with completion handler")
                    completionHandler(userCottages)
                }
            }
            else {
                print("Document does not exist")
                completionHandler([])
            }
        }
        
    }
    
    func createCottage(name: String, address: String, startDate: String, endDate: String, userID: String, organiserName: String, completionHandler: @escaping (String?) -> ()) {
        
        //firestore reference
        let db = Firestore.firestore()
        
        //collections references
        let cottagesCollection = db.collection("cottages")
        
        //get the user document
        let userDoc = self.getUserDocument(for: userID)
        
        //create the reference for the organizer's user document
        let organizerAttendeeRef: DocumentReference = db.document("users/\(userID)")
        
        userDoc.getDocument() { (document, error) in
            if let document = document, document.exists {
                let newCottageDoc = cottagesCollection.document()
                newCottageDoc.setData([
                    "address" : address,
                    "organizer" : organizerAttendeeRef,
                    "tripName" : name,
                    "startDate" : startDate,
                    "endDate" : endDate,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
                newCottageDoc.collection("attendees").document(userID).setData([
                    "userDoc" : organizerAttendeeRef
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
                userDoc.updateData([
                    "cottageIDs" : FieldValue.arrayUnion([newCottageDoc.documentID])
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                
                completionHandler(newCottageDoc.documentID)
            }
            else {
                print("document does not exist for user id: \(userID)")
                completionHandler(nil)
            }
        }
        
    }
    
    func getUserDocument(for userID: String) -> DocumentReference {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let usersRef = db.collection("users")
        
        //get the user document
        let userDocument = usersRef.document(userID)
        return userDocument
        
    }
    
    func add(user id: String, to cottageID: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let usersRef = db.collection("users")
        
        //get the user document
        let userDocument = usersRef.document(id)
        
        //append new cottage to user cottage array
        userDocument.updateData([
            "cottageIDs" : FieldValue.arrayUnion([cottageID])
        ]) { err in
            if let err = err {
                print("Error adding \(cottageID) to user document: \(err)")
            } else {
                print("Document successfully updated")
            }
        
        }
        
    }
    
    func remove(user id: String, from cottageID: String) {
        
        //to implement
        
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
                cottageModel.cottageID = cottage
                
                //get the subcollections of this document
                let attendeesCollection = cottageRef.collection("attendees")
                let carsCollection = cottageRef.collection("cars")
                let drinksCollection = cottageRef.collection("drinks")
                let groceriesCollection = cottageRef.collection("groceries")
                let roomsCollection = cottageRef.collection("rooms")
                
                //get the necessary trip information
                let tripName: String = document.get("tripName") as! String
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
                cottageModel.startDate = startDate
                cottageModel.endDate = endDate
                cottageModel.address = address
                
                //creat the dispatch groups
                let group = DispatchGroup()
                let attendeesGroup = DispatchGroup()
                
                //group enter for getting organizer user doc and data
                //group enter for the attendess get documents async task
                group.enter()
                group.enter()
                print("group enter")
                print("group enter")
                
                //organizer user get doc async call
                let organizerUserDoc: DocumentReference = document.get("organizer") as! DocumentReference
                organizerUserDoc.getDocument() { document, error in
                    if let document = document, document.exists {
                        let organizerName = document.get("fullName") as! String
                        let organizerID = document.documentID
                        let organizerAttendeeModel = Attendee(name: organizerName, firebaseUserID: organizerID)
                        cottageModel.tripOrganiser = organizerAttendeeModel
                        group.leave()
                    }
                }
                
                //attendees get document async call
                attendeesCollection.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                            print("Error getting documents: \(err)")
                    } else {
                        
                        //first get the attendees
                        for document in querySnapshot!.documents {
                            
                            print("attendees group enter")
                            attendeesGroup.enter()
                            
                            let attendeeDocument = document.get("userDoc") as! DocumentReference
                            attendeeDocument.getDocument() { document, error in
                                if let document = document, document.exists {
                                    let attendeeName = document.get("fullName") as! String
                                    let attendeeFirebaseID = document.documentID
                                    let attendeeToAdd = Attendee(name: attendeeName, firebaseUserID: attendeeFirebaseID)
                                    cottageModel.attendeesList.append(attendeeToAdd)
                                    print("attendees group leave")
                                    attendeesGroup.leave()
                                }
                            }
                            
                        }
                        
                        //this is where the attendees group should be finished with tasks before continuing
                        attendeesGroup.notify(queue: .main) {
                            print("entering attendeesGroup notify block")
                        
                            //get the cars
                            print("group enter")
                            group.enter()
                            carsCollection.getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                        print("Error getting documents: \(err)")
                                } else {
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
                                print("group leave")
                                group.leave()
                            }
                            
                            //get the drinks
                            print("group enter")
                            group.enter()
                            drinksCollection.getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                        print("Error getting documents: \(err)")
                                } else {
                                    //drink data manipulation
                                    
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
                                        
                                        cottageModel.drinksList[drinkListAttendee] = userDrinks
                                        
                                    }
                                }
                                print("group leave")
                                group.leave()
                            }
                            
                            //get the groceries
                            print("group enter")
                            group.enter()
                            groceriesCollection.getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                        print("Error getting documents: \(err)")
                                } else {
                                    //groceries data manipulation
                                    
                                    for document in querySnapshot!.documents {
                                        
                                        let groceryName = document.documentID
                                        let price: Double = document.get("price") as! Double
                                        let quantity: Int = document.get("quantity") as! Int
                                        let assignedUserId = document.get("assignedTo") as! String
                                        
                                        let groceryToAdd = Grocery(productName: groceryName, price: price, quantity: quantity, assignedTo: assignedUserId)
                                        
                                        if assignedUserId != "" {
                                            let assignedAttendee: Attendee = cottageModel.attendeesList.first(where: { $0.firebaseUserID == assignedUserId } )!
                                            if cottageModel.groceryList.groceryLists[assignedAttendee] == nil {
                                                cottageModel.groceryList.groceryLists[assignedAttendee] = []
                                            }
                                            cottageModel.groceryList.groceryLists[assignedAttendee]!.append(groceryToAdd)
                                            cottageModel.groceryList.allItems.append(groceryToAdd)
                                        }
                                        else {
                                            cottageModel.groceryList.allItems.append(groceryToAdd)
                                        }
                                        
                                    }
                                }
                                print("group leave")
                                group.leave()
                            }
                            
                            //get the rooms/beds
                            print("group enter")
                            group.enter()
                            roomsCollection.getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                        print("Error getting documents: \(err)")
                                } else {
                                    //room/bed data manipulation
                                    
                                    for document in querySnapshot!.documents {
                                        
                                        var bedDict = [String : Int]()
                                        bedDict["Singles"] = document.get("singles") as? Int
                                        bedDict["Doubles"] = document.get("doubles") as? Int
                                        bedDict["Queens"] = document.get("queens") as? Int
                                        bedDict["Kings"] = document.get("kings") as? Int
                                        
                                        let roomToAdd = Room(bedDict: bedDict, roomID: document.documentID)
                                        
                                        cottageModel.roomsList.append(roomToAdd)
                                        
                                    }
                                }
                                print("group leave")
                                group.leave()
                            }
                            
                            print("group leave")
                            group.leave()
                            
                        //end of attendees group notify
                        }
                        
                    //end of attendees collection get documents else (no error)
                    }
                    
                    //return the cottage model to the completion handler only when all tasks are complete
                    group.notify(queue: .main) {
                        print("group notify block entered, ending with completion handler")
                        completionHandler(cottageModel)
                    }
                    
                //end of attendeesCollection.getDocuments()
                }
                
            // end of cottageRef.getDocument if let document = document, document.exists
            } else {
                print("Document does not exist")
                completionHandler(nil)
            }
            
        //end of cottageRef.getDocument
        }
        
    }
    
    func upload(grocery: Grocery, for user: String, to cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let groceriesCollection = cottageRef.collection("groceries")
        
        //add the document to the groceries collection
        groceriesCollection.document(grocery.productName).setData([
            "assignedTo" : user,
            "price" : grocery.price,
            "quantity" : grocery.quantity
        ]) { err in
            
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
        }
        
    }
    
    func delete(grocery: Grocery, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let groceriesCollection = cottageRef.collection("groceries")
        
        //remove the grocery from the collection
        groceriesCollection.document(grocery.productName).delete() { err in
            if let err = err {
                print("Error deleting grocery: \(err)")
            } else {
                print("Grocery successfully deleted!")
            }
        }
        
    }
    
    func addCar(drivenBy passengerID: String, holding numberOfSeats: Int, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the cars collection
        let groceriesCollection = cottageRef.collection("cars")
        
        //add the document to the groceries collection
        groceriesCollection.document(passengerID).setData([
            "numberOfSeats" : numberOfSeats,
            "passengers" : [],
            "requests" : []
        ]) { err in
            
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
        }
        
    }
    
    func deleteCar(drivenBy passengerID: String, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let carsCollection = cottageRef.collection("cars")
        
        //remove the car from the collection
        carsCollection.document(passengerID).delete() { err in
            if let err = err {
                print("Error deleting car: \(err)")
            } else {
                print("Car successfully deleted!")
            }
        }
        
    }
    
    func removeAll(requestsFrom passengerID: String, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let carsCollection = cottageRef.collection("cars")
        
        carsCollection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                    print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.updateData([
                        "requests": FieldValue.arrayRemove([passengerID])
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
        }
        
    }
    
    func create(requestFor userID: String, for car: Car, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let carsCollection = cottageRef.collection("cars")
        
        //get the car document reference
        let carReference = carsCollection.document(car.driver.firebaseUserID)
        
        //add the requester to the requests
        carReference.updateData([
            "requests": FieldValue.arrayUnion([userID])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    func acceptRequest(for user: String, in car: Car, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let carsCollection = cottageRef.collection("cars")
        
        //get the car document reference
        let carReference = carsCollection.document(car.driver.firebaseUserID)
        
        //make sure that the requster actually requested a spot in this car
        carReference.getDocument() { (document, error) in
            
            var requests: [String] = []
            if let document = document, document.exists {
                requests = document.get("requests") as! [String]
            }
            
            //if the user is not in the requests, return
            if !requests.contains(user) {
                return
            }
            
            //add the user as a passenger to the car
            carReference.updateData([
                "passengers": FieldValue.arrayUnion([user])
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
            //remove all requests by this user in all cars
            self.removeAll(requestsFrom: user, in: cottage)
            
        }
        
    }
    
    func decline(requestFrom user: String, in car: Car, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let carsCollection = cottageRef.collection("cars")
        
        //get the car document reference
        let carReference = carsCollection.document(car.driver.firebaseUserID)
        
        carReference.updateData([
            "requests": FieldValue.arrayRemove([user])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    func remove(passenger id: String, from car: Car, in cottageID: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottageID)
        
        //get the groceries collection
        let carsCollection = cottageRef.collection("cars")
        
        //get the car document reference
        let carReference = carsCollection.document(car.driver.firebaseUserID)
        
        carReference.updateData([
            "passengers": FieldValue.arrayRemove([id])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    func add(room: Room, to cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let roomsCollection = cottageRef.collection("rooms")
        
        let newRoomReference = roomsCollection.document()
        
        room.roomID = newRoomReference.documentID
        
        //create the new document
        newRoomReference.setData([
            "singles": room.bedDict["Singles"] ?? 0,
            "doubles": room.bedDict["Doubles"] ?? 0,
            "queens": room.bedDict["Queens"] ?? 0,
            "kings": room.bedDict["Kings"] ?? 0
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    func delete(room id: String, in cottage: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottage)
        
        //get the groceries collection
        let roomsCollection = cottageRef.collection("rooms")
        
        roomsCollection.document(id).delete() { err in
            if let err = err {
                print("Error deleting room: \(err)")
            } else {
                print("Room successfully deleted!")
            }
        }
        
    }
    
    func add(drink: Drink, for userID: String, in cottageID: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottageID)
        
        //get the groceries collection
        let drinksCollection = cottageRef.collection("drinks")
        
        //get the users collection of drinks or create it if it doesnt exist
        let userDrinksDocument = drinksCollection.document(userID)
        
        let drinkArray = [drink.isAlcoholic, drink.forSharing]
        userDrinksDocument.setData([
            drink.name: drinkArray
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully created")
            }
        }
        
    }
    
    func delete(drink: Drink, for userID: String, in cottageID: String) {
        
        //get a reference to the firestore
        let db = Firestore.firestore()
        
        //get the references to the collections
        let cottageRef = db.collection("cottages").document(cottageID)
        
        //get the groceries collection
        let drinksCollection = cottageRef.collection("drinks")
        
        //get the users collection of drinks or create it if it doesnt exist
        let userDrinksDocument = drinksCollection.document(userID)
        
        userDrinksDocument.updateData([
            drink.name: FieldValue.delete()
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
}
