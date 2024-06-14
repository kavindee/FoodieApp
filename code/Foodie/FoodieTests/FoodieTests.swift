//
//  FoodieTests.swift
//  FoodieTests
//
//  Created by kavin on BE 2567-06-12.
//

import XCTest
import CoreData
@testable import Foodie

class FoodieTests: XCTestCase {

    var viewModel: cddatamodel!

    override func setUpWithError() throws {
        // Initialize the view model with an in-memory NSPersistentContainer
        viewModel = cddatamodel()
        viewModel.container = {
            let container = NSPersistentContainer(name: "CoreDataFoodClass")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { (description, error) in
                if let error = error {
                    fatalError("Unable to load in-memory store: \(error)")
                }
            }
            return container
        }()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testAddBreakfast() throws {
        viewModel.addBreakfast(icon: "taco", name: "Taco", ingredients: "Cheese, Meat", fat: 10, protein: 20, cards: 30)
        XCTAssertEqual(viewModel.saveBreakfastEntity.count, 1)
        let breakfast = viewModel.saveBreakfastEntity.first
        XCTAssertEqual(breakfast?.icon, "taco")
        XCTAssertEqual(breakfast?.name, "Taco")
        XCTAssertEqual(breakfast?.ingrediants, "Cheese, Meat")
        XCTAssertEqual(breakfast?.fat, 10)
        XCTAssertEqual(breakfast?.protein, 20)
        XCTAssertEqual(breakfast?.cards, 30)
    }

    func testAddLunch() throws {
        viewModel.addLunch(icon: "pizza", name: "Pizza", ingredients: "Cheese, Tomato", fat: 15, protein: 25, cards: 35)
        XCTAssertEqual(viewModel.saveLunchEntity.count, 1)
        let lunch = viewModel.saveLunchEntity.first
        XCTAssertEqual(lunch?.icon, "pizza")
        XCTAssertEqual(lunch?.name, "Pizza")
        XCTAssertEqual(lunch?.ingredients, "Cheese, Tomato")
        XCTAssertEqual(lunch?.fat, 15)
        XCTAssertEqual(lunch?.protein, 25)
        XCTAssertEqual(lunch?.cards, 35)
    }

    func testAddValue() throws {
        viewModel.addValue(fat: 5, protein: 10, cards: 15)
        let valueEntity = viewModel.saveValueEntity.first
        XCTAssertEqual(valueEntity?.fat, 5)
        XCTAssertEqual(valueEntity?.protein, 10)
        XCTAssertEqual(valueEntity?.cards, 15)
    }
}
