//
//  WaterView.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//
import SwiftUI

// Main waterView struct
struct WaterView: View {
    @State var checkmark = [false, false, false, false, false, false] // State array to track which glasses have been drunk
    
    var body: some View {
        VStack {
            // header showing the number of glasses drunk
            HStack {
                Text("\(checkmark.filter { $0 }.count) of 6 glasses").bold()
                    .font(.title3)
                    .offset(y:-10)
                Spacer()
                Image("cup")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 35)
            }
            .padding(.horizontal)
            
            // Row of water drop icons representing glasses of water
            HStack {
                ForEach(0 ..< 6, id: \.self) { index in
                    ZStack {
                        Circle() // Background circle for each water drop
                            .frame(width: 50, height: 45)
                            .foregroundColor(.blue.opacity(checkmark[index] ? 0.1 : 0.03))
                        HStack {
                            Image("drop")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height: 40)
                                .onTapGesture {
                                    checkmark[index].toggle() // Toggle the checkmark for this glass
                                }
                        }
                    }
                    .overlay(alignment: .topTrailing, content: {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 15, height: 15)
                            Image(systemName: checkmark[index] ? "checkmark" : "").bold()
                                .font(.system(size: 10))
                                .foregroundColor(.green)
                        }
                    })
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .modifier(customeShadow())
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
