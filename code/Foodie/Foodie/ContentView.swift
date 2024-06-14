//
//  ContentView.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//
import SwiftUI

// Main ContentView struct
struct ContentView: View {
    //EnvironmentObject to access the data model
    @EnvironmentObject var vm: cddatamodel
    // State variable to track the selected tab
    @State var itemselected: Tab = .Breakfast
    @State var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Header greeting and profile image
                HStack {
                    Text("Hi Mohan").bold()
                        .font(.system(size: 30))
                    Spacer()
                    NavigationLink(destination: ProfileView()){
                        Image("foodie")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .shadow(color: .blue, radius: 20, x: 0, y: 0)
                            .clipShape(Circle())
                    }
                }
                .padding()
                
                // Circle view displayin progress
                CircleView()
                
                // Tab view for selecting different meal times
                TabView(itemselected: $itemselected)
                
                // Display meals based on selected tab
                if itemselected == .Breakfast {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.saveBreakfastEntity) { item in
                                FoodCard(width: 200, cards: CGFloat(item.cards), protein: CGFloat(item.protein), fat: CGFloat(item.fat), name: item.name ?? "", title: item.ingrediants ?? "", icon: item.icon ?? "")
                                    .padding(.leading)
                                    // Button to add meal and update values
                                    .overlay(alignment: .topTrailing, content: {
                                        Button(action: {
                                            vm.addValue(fat: CGFloat(item.fat), protein: CGFloat(item.protein), cards: CGFloat(item.cards))
                                            vm.addMealToggle(meal: item)
                                            vm.addRingCalories(calories: CGFloat(item.cards))
                                        }, label: {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.white)
                                                Image(systemName: item.addMale ? "checkmark" : "plus")
                                                    .imageScale(.small)
                                                    .foregroundColor(.black)
                                            }
                                            .modifier(customeShadow())
                                        })
                                        .offset(x: -5, y: 5)
                                    })
                                // Button to delete meal
                                    .overlay(alignment: .bottomTrailing, content: {
                                        Button(action: {
                                            vm.deleteMeal(meal: item)
                                        }, label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        })
                                        .padding()
                                    })
                            }
                        }
                        .frame(height: 180)
                    }
                    .offset(y: -30)
                } else if itemselected == .Lunch {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.saveLunchEntity) { item in
                                FoodCard(width: 200, cards: CGFloat(item.cards), protein: CGFloat(item.protein), fat: CGFloat(item.fat), name: item.name ?? "", title: item.ingredients ?? "", icon: item.icon ?? "")
                                    .padding()
                                
                            }
                        }
                        .frame(height: 180)
                    }
                    .offset(y: -30)
                }else if itemselected == .Snacks {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.saveLunchEntity) { item in
                                FoodCard(width: 200, cards: CGFloat(item.cards), protein: CGFloat(item.protein), fat: CGFloat(item.fat), name: item.name ?? "", title: item.ingredients ?? "", icon: item.icon ?? "")
                                    .padding()
                            }
                        }
                        .frame(height: 180)
                    }
                    .offset(y: -30)
                }else if itemselected == .Dinner {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.saveLunchEntity) { item in
                                FoodCard(width: 200, cards: CGFloat(item.cards), protein: CGFloat(item.protein), fat: CGFloat(item.fat), name: item.name ?? "", title: item.ingredients ?? "", icon: item.icon ?? "")
                                    .padding()
                            }
                        }
                        .frame(height: 180)
                    }
                    .offset(y: -30)
                }
                // Water intake view
                WaterView()
                    .offset(y: -60)
                
                Spacer()
                    .overlay(alignment: .bottomLeading, content: {
                        HStack {
                            Button(action: {
                                show.toggle()
                            }, label: {
                                Text("New Meal").bold()
                                    .foregroundColor(.black)
                                    .frame(width: 150, height: 50)
                                    .background(.white)
                                    .clipShape(Capsule())
                                    .modifier(customeShadow())
                            })
                            .padding()
                            
                        }
                    })
                
            }
                .sheet(isPresented: $show, content: { // Show addView when the enw meal button is tapped
                    AddView()
                })
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(cddatamodel())
    }
}
