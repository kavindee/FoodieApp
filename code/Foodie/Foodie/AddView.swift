//
//  AddView.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//

import SwiftUI

// Struct to represent a meal icon
struct meal:Identifiable{
    var id = UUID() // Unique identifier for each meal
    var image:String // Image name for the meal
}

// Array of meal icons to be used in AddView
var icons:[meal] = [
    meal(image: "taco"),
    meal(image: "noodles"),
    meal(image: "pizza"),
    meal(image: "donut"),
    meal(image: "meat"),
    meal(image: "hotdog"),
    meal(image: "sandwich"),
    meal(image: "fish")
]

// Main addView struct
struct AddView: View {
    @Environment(\.presentationMode) var envi
    @EnvironmentObject var vm:cddatamodel
    @State var itemselected:Tab = .Breakfast
    @State var showicons:Bool = false
    @State var icon:String = "plus"
    @State var name:String = ""
    @State var title:String = ""
    @State var fat:String = "0"
    @State var protein:String = "0"
    @State var cards:String = "0"
    @State var fatTF:Bool = false
    @State var proteinTF:Bool = false
    @State var cardsTF:Bool = false
    var body: some View {
        VStack{
            Spacer()
            
            // Display the tab view
            TabView(itemselected: $itemselected)
            
            VStack(spacing: 25){
                Image(icon) // Display the selected icon
                    .resizable()
                    .scaledToFill()
                    .background(.yellow)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        withAnimation{showicons.toggle()} // Toggle the visibility of icons
                    }
                
                // Show/hide meal icons
                if showicons{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                        ForEach(icons) { item in
                            Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        icon = item.image // set the selected icon
                                        withAnimation{showicons.toggle()} // Hide the icons
                                    }
                            }
                        }
                    }
                }
                
                // Text fields for name and title
                VStack{
                    TextField("name", text: $name)
                    Divider()
                    TextField("title", text: $title)
                }
                .font(.title3)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .modifier(customeShadow())
                
                // Value input for fat, protein, and carbs
                VStack{
                    values(number: $fat, show: $fatTF, name: "Fat")
                    values(number: $protein, show: $proteinTF, name: "Protein")
                    values(number: $cards, show: $cardsTF, name: "Carbs")
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .modifier(customeShadow())
                
                //  Save button to add the meal
                Button(action: {
                    switch itemselected {
                    case .Breakfast:
                        vm.addBreakfast(icon: icon, name: name, ingredients: title, fat: CGFloat(Int(fat) ?? 0 ), protein: CGFloat(Int(protein) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Lunch:
                        vm.addLunch(icon: icon, name: name, ingredients: title, fat: CGFloat(Int(fat) ?? 0 ), protein: CGFloat(Int(protein) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Dinner:
                        print("Dinner")
                    case .Snacks:
                        print("Snacks")
                    }
                    
                }, label: {
                    Text("Save").bold()
                        .font(.title2)
                        .foregroundColor(.green)
                        .frame(width: 180, height: 50)
                        .background(.white)
                        .cornerRadius(10)
                        .modifier(customeShadow())
                })
            }
            .padding()
            Spacer()
        }
        .overlay(alignment: .topTrailing, content: {
            
            // Close button  to dismiss the view
            Button(action: {
                envi.wrappedValue.dismiss()
            }, label: {
                ZStack{
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
                .modifier(customeShadow())
                .padding()
            })
        })
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(cddatamodel())
    }
}

// Struct to handle input values for fat, protein, and carbs
struct values: View {
    @Binding var number:String // Binding to track the input value
    @Binding var show:Bool // Binding to show/hide the picker
    var name = "" // Name of the nutrient
    
    var body: some View {
        HStack{
            Text(name).bold() // Dispay the name of the nutrient
                .font(.title2)
            Spacer()
            Text("\(number)").bold() // Display the current value
                .font(.title2)
                .frame(width: 45, height: 30)
                .background(.green)
                .cornerRadius(5)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation{show.toggle() // Toggle the picker Visibility
                        
                    }
                }
            
            // show/hide the picker for selecting nutrient values
            if show{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 5){
                        ForEach(1 ..< 100) { item in
                            Text("\(item)").bold() // Display the picker item
                                .frame(width: 30, height: 30)
                                .background(.green.opacity(0.2))
                                .cornerRadius(5)
                                .onTapGesture {
                                    show.toggle() // hide the picker
                                    number = "\(item)" // set the selected value
                                }
                        }
                    }
                }
                .frame(width: 180, height: 30)
            }
            
        }
        .padding(5)
    
    }
}
