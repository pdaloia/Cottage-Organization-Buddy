//
//  TestHelper.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-19.
//

import Foundation

class TestHelper {
    
    static func loadTestModel(into model: CottageTrip) {
        
        let modelToLoad = model
        
        //create attendees
        let phil = Attendee(name: "Phil", firebaseUserID: "")
        let vic = Attendee(name: "Vic", firebaseUserID: "")
        let andrew = Attendee(name: "Andrew", firebaseUserID: "")
        let medei = Attendee(name: "Medei", firebaseUserID: "")
        let sonia = Attendee(name: "Sonia", firebaseUserID: "")
        let laura = Attendee(name: "Laura", firebaseUserID: "")
        let jules = Attendee(name: "Jules", firebaseUserID: "")
        let kim = Attendee(name: "Kim", firebaseUserID: "")
        let abosh = Attendee(name: "Abosh", firebaseUserID: "")
        let erica = Attendee(name: "Erica", firebaseUserID: "")
        let michael = Attendee(name: "Michael", firebaseUserID: "")
        let lucas = Attendee(name: "Lucas", firebaseUserID: "")
        let ricky = Attendee(name: "Ricky", firebaseUserID: "")
        
        //name the trip
        modelToLoad.tripName = "Vic's Cottage 2020"
        
        //load the attendees into the trip
        modelToLoad.tripOrganiser = vic
        modelToLoad.attendeesList = [phil, vic, andrew, medei, sonia, laura, jules, kim, abosh, erica, michael, lucas, ricky]
        
        //load the trip's information
        var startDateComponents = DateComponents()
        startDateComponents.year = 2020
        startDateComponents.month = 8
        startDateComponents.day = 16
        startDateComponents.hour = 12
        
        var endDateComponents = DateComponents()
        endDateComponents.year = 2020
        endDateComponents.month = 8
        endDateComponents.day = 20
        endDateComponents.hour = 12
        
        let calendar = Calendar(identifier: .gregorian)
        
        modelToLoad.startDate = calendar.date(from: startDateComponents)!
        modelToLoad.endDate = calendar.date(from: endDateComponents)!
        
        modelToLoad.address = "19 Ann Street"
        
        //load the groceries
        let bananas: Grocery = Grocery(productName: "Banana", price: 2.00, quantity: 5)
        let apples: Grocery = Grocery(productName: "Apple", price: 1.50, quantity: 10)
        let burgers: Grocery = Grocery(productName: "Burger", price: 5.00, quantity: 10)
        let popsicles: Grocery = Grocery(productName: "Popsicle", price: 2.50, quantity: 20)
        
        let allGroceries = [bananas, apples, burgers, popsicles]
        var groceryListsDict = [Attendee:[Grocery]]()
        groceryListsDict[phil] = []
        groceryListsDict[phil]?.append(contentsOf: [apples, bananas])
        groceryListsDict[vic] = []
        groceryListsDict[vic]?.append(contentsOf: [burgers])
        groceryListsDict[medei] = []
        groceryListsDict[medei]?.append(contentsOf: [popsicles])
    
        modelToLoad.groceryList = GroceryLists(allItems: allGroceries, groceryLists: groceryListsDict)
        
        //load cars and requests
        let firstCar = Car(driver: phil, numberOfSeats: 3, passengers: [medei, sonia], requests: [])
        let secondCar = Car(driver: michael, numberOfSeats: 3, passengers: [vic, andrew], requests: [])
        let thirdCar = Car(driver: jules, numberOfSeats: 3, passengers: [kim, lucas], requests: [])
        let fourthCar = Car(driver: abosh, numberOfSeats: 3, passengers: [erica], requests: [])
        
        let rickyCarRequest = CarRequest(requester: ricky)
        firstCar.requests = [rickyCarRequest]
        
        modelToLoad.carsList = [firstCar, secondCar, thirdCar, fourthCar]
        
        //load rooms and beds
        let firstBed: Bed = Bed(size: .twin)
        let secondBed: Bed = Bed(size: .king)
        let thirdBed: Bed = Bed(size: .double)
        let fourthBed: Bed = Bed(size: .double)
        let fifthBed: Bed = Bed(size: .twin)
        
        let firstRoom: Room = Room(bedList: [firstBed, thirdBed, fourthBed, fifthBed])
        let secondRoom: Room = Room(bedList: [secondBed])
        
        modelToLoad.roomsList = [secondRoom, firstRoom]
        
        //load drinks
        let tequila: Drink = Drink(name: "Tequila", isAlcoholic: true, forSharing: true)
        let cranberryJuice = Drink(name: "Cranberry Juice", isAlcoholic: false, forSharing: false)
        let Vodka = Drink(name: "Vodka", isAlcoholic: true, forSharing: true)
        let water = Drink(name: "Water", isAlcoholic: false, forSharing: true)
        let moreWater = Drink(name: "More Water", isAlcoholic: false, forSharing: true)
        let waterWithExtraH2O = Drink(name: "Water with extra H2O", isAlcoholic: false, forSharing: false)
        let lcboDrink = Drink(name: "Drink no one cares about", isAlcoholic: true, forSharing: true)
        let lcboDrink2 = Drink(name: "Expensive drink no one cares about", isAlcoholic: true, forSharing: true)
        let lcboDrink3 = Drink(name: "Drink that shows I work at LCBO", isAlcoholic: true, forSharing: true)
        let mikesHard = Drink(name: "Mike's hard", isAlcoholic: true, forSharing: false)
        
        let philsList: PersonalDrinksList = PersonalDrinksList(person: phil, drinkNames: [tequila, cranberryJuice, Vodka])
        let medeisList: PersonalDrinksList = PersonalDrinksList(person: medei, drinkNames: [lcboDrink, lcboDrink2, lcboDrink3, mikesHard])
        let julesList: PersonalDrinksList = PersonalDrinksList(person: jules, drinkNames: [water, moreWater, waterWithExtraH2O])
        
        modelToLoad.drinksList = [philsList, medeisList, julesList]
        
    }
    
}
