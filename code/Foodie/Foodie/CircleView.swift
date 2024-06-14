//
//  CircleView.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//

import SwiftUI

// Custome shadow modifier
struct customeShadow:ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}

// Main CircleView struct
struct CircleView: View {
    @EnvironmentObject var vm:cddatamodel // EnviromentObject to access the data model
    var percent :CGFloat = 50
    var width :CGFloat = 130
    var height :CGFloat = 130
    var perc: CGFloat = 1000
    
    var body: some View {
        let circleValue = vm.saveValueEntity.first // get the first value entity
        let multiplier = width / 44 // multiplier for scaling elements within the circle
        let progress = 1 - (circleValue?.ring ?? 0 / 1700)
        //let progress = 1 - (perc / 1700)
        
        return HStack(spacing: 40) {
            ZStack {
                //background circle
                Circle()
                    .stroke(Color.blue.opacity(0.1),style: StrokeStyle(lineWidth: 4 * multiplier))
                    .frame(width: width, height: height)
                
                //Foreground circle to show progress
                Circle()
                    .trim(from: CGFloat(progress), to: 1)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("cards"),.blue]), startPoint: .top, endPoint: .bottom),style: StrokeStyle(lineWidth: 4 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)
                    )
                    .rotationEffect(Angle(degrees: 90)) // Rotate the circle to start from the top
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0)) // Flip the circle
                    .frame(width: width, height: height)
                
                //Display the ring value in the center
                Text("1790").bold()
                    .font(.title)
                
                // Reset button with icon
                Button(action: {
                    vm.resetCircleView()
                }) {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 30, height: 30)
                }
                .offset(x: width / 2 - 20, y: -height / 2 + 20) // Adjust the position as needed
            }
            
            
        // Display nutrient values
        HStack(spacing: 30){
            ForEach(vm.saveValueEntity){ item in
                foodElementValue(element: "cards", gram: String(format: "%.0f", item.cards), color: .customBlue, elementValue: CGFloat(item.cards))
                foodElementValue(element: "fat", gram: String(format: "%.0f", item.fat), color: .customGreen, elementValue: CGFloat(item.fat))
                foodElementValue(element: "protein", gram: String(format: "%.0f", item.protein), color: .customOrange, elementValue: CGFloat(item.protein))
                   
            }
        }

        }
    .frame(height: 180)
    .frame(width: UIScreen.main.bounds.width - 20)
    .background(Color.white)
    .cornerRadius(20)
    .modifier(customeShadow())
    
    }
}



struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
            .environmentObject(cddatamodel())
    }
}

// Struct to display nutrient values
struct foodElementValue:View{
    var element = ""
    var gram = ""
    var color: Color = .gray
    var elementValue: CGFloat = 0
    
    var body: some View{
        let height : CGFloat = 130
        let multiplier = height / 2000 // Multiplier for scaling the rectangle height
        
        return VStack{
            ZStack(alignment: .bottom){
                // Background rectangle
                Rectangle()
                    .frame(width: 8, height: 110)
                    .foregroundColor(.gray.opacity(0.5))
                
                // Foreground rectangle to shoow nutrient amount
                if elementValue != 0 {
                    Rectangle()
                        .frame(width: 8, height: elementValue * multiplier)
                        .foregroundColor(color)
                }else {
                    Rectangle()
                        .frame(width: 8, height: 110)
                        .foregroundColor(color)
                }
            }
            .cornerRadius(10)
            
            // Display the nutrient name and amount
            Text(element)
                .font(.system(size: 12))
            Text(gram)
                .font(.system(size: 10))
        }
    }
}

extension Color {
    static let customBlue = Color(red: 0.0, green: 0.478, blue: 1.0)
    static let customGreen = Color(red: 0.0, green: 0.8, blue: 0.0)
    static let customOrange = Color(red: 1.0, green: 0.6, blue: 0.0)
}

