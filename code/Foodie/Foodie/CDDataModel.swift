//
//  CDDataModel.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//
import Foundation
import CoreData

// Class to manage Core Data operations
class cddatamodel: ObservableObject {
    let container: NSPersistentContainer // Persisitent container for Core data
    @Published var saveBreakfastEntity: [BreakfastEntity] = [] // Published array to hold breakfast entities
    @Published var saveLunchEntity: [LunchEntity] = []
    @Published var saveValueEntity: [ValueEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "CoreDataFoodClass") // Inititalize the persistent container with the coreData model name
        container.loadPersistentStores { (description, error) in // Load persistent stores
            if let error = error {
                print("Error loading data \(error)")
            }
        }
        fetchData() // Fetch initial data
    }
    
    // Fetch data from Core Data
    func fetchData() {
        let requestOne = NSFetchRequest<BreakfastEntity>(entityName: "BreakfastEntity") // Request for breakfast entities
        let requestTwo = NSFetchRequest<LunchEntity>(entityName: "LunchEntity")
        let requestThree = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        
        do {
            saveBreakfastEntity = try container.viewContext.fetch(requestOne) // Fetch breakfast entities
            saveLunchEntity = try container.viewContext.fetch(requestTwo)
            saveValueEntity = try container.viewContext.fetch(requestThree)
        } catch let error {
            print("Error fetching data \(error)")
        }
    }
    
    //Function to add a new breakfast meal
    func addBreakfast(icon: String, name: String, ingredients: String, fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newMeal = BreakfastEntity(context: container.viewContext) // Create a new breakfast entity
        newMeal.icon = icon
        newMeal.name = name
        newMeal.ingrediants = ingredients
        newMeal.fat = Float(fat)
        newMeal.protein = Float(protein)
        newMeal.cards = Float(cards)
        saveData()
    }
    
    // Function to add a new lunch meal
    func addLunch(icon: String, name: String, ingredients: String, fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newMeal = LunchEntity(context: container.viewContext) // create a new lunch entity
        newMeal.icon = icon
        newMeal.name = name
        newMeal.ingredients = ingredients
        newMeal.fat = Float(fat)
        newMeal.protein = Float(protein)
        newMeal.cards = Float(cards)
        saveData()
    }
    
    //Function to update value entities with new fat, protein, and cabrs values
    func addValue(fat: CGFloat, protein: CGFloat, cards: CGFloat) {
        let newValue = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do {
            let results = try container.viewContext.fetch(newValue)
            if let entity = results.first {
                entity.fat += Float(fat)
                entity.protein += Float(protein)
                entity.cards += Float(cards)
            } else {
                let newValue = ValueEntity(context: container.viewContext)
                newValue.fat = Float(fat)
                newValue.protein = Float(protein)
                newValue.cards = Float(cards)
            }
            saveData()
            fetchData()
        } catch {
            print("\(error)")
        }
    }
    // function to update the ring calories
    func addRingCalories(calories: CGFloat) {
        let newCal = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do {
            let results = try container.viewContext.fetch(newCal)
            if let entity = results.first {
                entity.ring += Float(Int(calories))
            } else {
                let newEntity = ValueEntity(context: container.viewContext)
                newEntity.ring = 10
            }
        } catch {
            print("\(error)")
        }
        saveData()
        fetchData()
    }
    
    // Function to toggle the meal status
    func addMealToggle(meal: BreakfastEntity) {
        meal.addMale.toggle()
        saveData()
    }
    
    // Function to delete a meal
    func deleteMeal(meal: BreakfastEntity) {
        container.viewContext.delete(meal)
        saveData()
    }
    
    // Function to reset the cirlce view values
    func resetCircleView() {
        let newCal = NSFetchRequest<ValueEntity>(entityName: "ValueEntity")
        do {
            let results = try container.viewContext.fetch(newCal)
            if let entity = results.first {
                entity.ring = 0
                entity.fat = 0
                entity.protein = 0
                entity.cards = 0
            }
        } catch {
            print("\(error)")
        }
        saveData()
        fetchData()
    }
    
    // Function to save the context
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch {
            print("Save data failed \(error)")
        }
    }
}
