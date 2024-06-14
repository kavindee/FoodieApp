//
//  FoodCard.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//

import SwiftUI

struct FoodCard: View {
    var width:CGFloat = 200
    @State var cards:CGFloat = 20
    @State var protein:CGFloat = 100
    @State var fat:CGFloat = 70
    @State var name:String = ""
    @State var title:String = ""
    @State var icon:String = ""
    
    var body: some View {
        let multipier = width / 40 //Multiplier for scaling elements within the card
        return VStack(alignment: .leading, spacing: 2){
            HStack{
                Text(name) //Display the name of the food
                    .font(.title2)
                    .frame(width: 160)
                    .lineLimit(1) // Limit text to one line
                    .minimumScaleFactor(0.7) // Scale down text if needed
            }
            .bold()
            HStack{
                Text(title) // Display addictional description of the needed
                Spacer()
            }
            .frame(width: 200, height: 30)
            .minimumScaleFactor(0.6) // Scale down text if needed
        }
        .offset(x: 20, y: -20)
        .frame(width: 270, height: 110)
        .background(.white)
        .cornerRadius(10)
        .modifier(customeShadow()) // Apply custome shadow modifier
        .overlay(alignment: .topLeading, content: {
            Image(icon) // Display the icon for the food
                .resizable()
                .scaledToFill()
                .frame(width: 65, height: 65)
                .offset(x: -12, y: -16)
        })
        .overlay(alignment: .bottom, content: {
            HStack{
                Elements(name: "cards", foodElement: cards, multipier: multipier, color: "cards") // Display carbohydrate content
                Elements(name: "fat", foodElement: fat, multipier: multipier, color: "fat") // Display fat content
                Elements(name: "protein", foodElement: protein, multipier: multipier, color: "protein") // Display protein content
            }
        })
    }
}

struct FoodCard_Previews: PreviewProvider {
    static var previews: some View {
        FoodCard()
    }
}

struct Elements: View {
    var name = "name" // Name of the nutrient
    var foodElement: CGFloat = 0 // Amount of the nutrient
    var multipier:CGFloat = 0 // Multipier for scaling the rectangle width
    var color = "" // Color name for the nutrient
    
    
    var body: some View{
        let width : CGFloat = 130
        let multipier = width / 200 // Multiplier for scaling the rectangle width
        return VStack{
            Text(name) // Display the name of the nutrient
                .font(.system(size: 12))
            Rectangle().frame(width: foodElement * multipier, height: 5) // Display a rectangle representing the nutrient amount
                .cornerRadius(5)
                .foregroundColor(.yellow) // Set the color of the bar
        }
        .padding(.bottom,5)
        .frame(width: 90)
    }
}
