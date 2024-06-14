//
//  FoodieApp.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-12.
//

import SwiftUI

@main
struct FoodieApp: App {
    @StateObject var vm : cddatamodel = cddatamodel()
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(cddatamodel())
        }
    }
}
