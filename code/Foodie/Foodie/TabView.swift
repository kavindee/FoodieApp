//
//  TabView.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//

import SwiftUI

// Struct to represent a selected food item and its corresponding tab
struct foodSelected:Identifiable{
    var id = UUID() // Unique identifier for each food item
    var food:String // Name of the food
    var tab:Tab // Corresponding tab for the food
}

// Array of the selected Food items to be used in the TabView
var selectedTab:[foodSelected] = [
    foodSelected(food: "Breakfast", tab: .Breakfast),
    foodSelected(food: "Lunch", tab: .Lunch),
    foodSelected(food: "Dinner", tab: .Dinner),
    foodSelected(food: "Snacks", tab: .Snacks)
    
]

//Enum to represent different tabs
enum Tab:String{
    case Breakfast
    case Lunch
    case Dinner
    case Snacks
}

// Main TabView struct
struct TabView: View {
    @Binding var itemselected :Tab // Binding variable to track the selected tab
    
    var body: some View {
        HStack(spacing: 30){
            ForEach(selectedTab) { item in // Itereate through each food item in selectedTab
                Button(action: {
                    withAnimation{
                        itemselected = item.tab // Set the selected tab
                    }
                }, label: {
                    Text(item.food) // Display the name of the food
                        .foregroundColor(itemselected == item.tab ? .white : .black) // Change text color based on selection
                        .padding(8)
                        .background(itemselected == item.tab ? .brown : Color("")) // Change background color based on selection
                        .cornerRadius(10)
                })
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(itemselected: .constant(.Breakfast))
    }
}
