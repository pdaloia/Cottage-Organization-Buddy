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
        let phil = Attendee(name: "Phil")
        let laura = Attendee(name: "Laura")
        let vic = Attendee(name: "Vic")
        let andrew = Attendee(name: "Andrew")
        let medei = Attendee(name: "Medei")
        let sonia = Attendee(name: "Sonia")
        let jules = Attendee(name: "Jules")
        let kim = Attendee(name: "Kim")
        let abosh = Attendee(name: "Abosh")
        let erica = Attendee(name: "Erica")
        let michael = Attendee(name: "Michael")
        let lucas = Attendee(name: "Lucas")
        let ricky = Attendee(name: "Ricky")
        
        //name the trip
        modelToLoad.tripName = "Vic's Cottage 2020"
        
        //load the attendees into the trip
        modelToLoad.tripOrganiser = vic
        modelToLoad.attendeesList = [phil, laura, vic, andrew, medei, sonia, jules, kim, abosh, erica, michael, lucas, ricky]
        
        //load the groceries
        let bananas: Grocery = Grocery(productName: "Banana", price: 2.00, Quantity: 5)
        let apples: Grocery = Grocery(productName: "Apple", price: 1.50, Quantity: 10)
        let burgers: Grocery = Grocery(productName: "Burger", price: 5.00, Quantity: 10)
        let popsicles: Grocery = Grocery(productName: "Popsicle", price: 2.50, Quantity: 20)
        
        let allGroceries = [bananas, apples, burgers, popsicles]
        
        let philsGroceries: GroceryList = GroceryList(person: phil, groceries: [apples, bananas])
        let vicsGroceries: GroceryList = GroceryList(person: vic, groceries: [burgers])
        let laurasGroceries: GroceryList = GroceryList(person: laura, groceries: [popsicles])
    
        modelToLoad.groceryList = GroceryLists(allItems: allGroceries, groceriesPerPerson: [philsGroceries, vicsGroceries, laurasGroceries])
        
        //load cars
        let firstCar = Car(driver: phil, numberOfSeats: 3, passengers: [laura, medei, sonia])
        let secondCar = Car(driver: michael, numberOfSeats: 3, passengers: [vic, andrew, ricky])
        let thirdCar = Car(driver: jules, numberOfSeats: 3, passengers: [kim, lucas])
        let fourthCar = Car(driver: abosh, numberOfSeats: 3, passengers: [erica])
        
        modelToLoad.carsList = [firstCar, secondCar, thirdCar, fourthCar]
        
        //load beds
        let firstBed: Bed = Bed(size: .double, capacity: 2, occupants: [phil, laura])
        let secondBed: Bed = Bed(size: .queen, capacity: 2, occupants: [vic, andrew])
        let thirdBed: Bed = Bed(size: .twin, capacity: 1, occupants: [jules])
        
        modelToLoad.bedsList = [firstBed, secondBed, thirdBed]
        
        //load drinks
        let tequila: Drink = Drink(name: "Tequila", isAlcoholic: true)
        let cranberryJuice = Drink(name: "Cranberry Juice", isAlcoholic: false)
        let Vodka = Drink(name: "Vodka", isAlcoholic: true)
        let water = Drink(name: "Water", isAlcoholic: false)
        let moreWater = Drink(name: "More Water", isAlcoholic: false)
        let waterWithExtraH2O = Drink(name: "Water with extra H2O", isAlcoholic: false)
        let lcboDrink = Drink(name: "Drink no one cares about", isAlcoholic: true)
        let lcboDrink2 = Drink(name: "Expensive drink no one cares about", isAlcoholic: true)
        let lcboDrink3 = Drink(name: "Drink that shows I work at LCBO", isAlcoholic: true)
        let mikesHard = Drink(name: "Mike's hard", isAlcoholic: true)
        
        let philsList: PersonalDrinksList = PersonalDrinksList(person: phil, drinkNames: [tequila, cranberryJuice, Vodka])
        let laurasList: PersonalDrinksList = PersonalDrinksList(person: laura, drinkNames: [water, moreWater, waterWithExtraH2O])
        let medeisList: PersonalDrinksList = PersonalDrinksList(person: medei, drinkNames: [lcboDrink, lcboDrink2, lcboDrink3, mikesHard])
        
        modelToLoad.drinksList = [philsList, laurasList, medeisList]
        
    }
    
}
