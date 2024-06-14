//
//  ProfileVIew.swift
//  Foodie
//
//  Created by kavin on BE 2567-06-13.
//
import SwiftUI
import MapKit

struct ProfileView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            // Map view taking 1/3 of the screen height
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .frame(height: UIScreen.main.bounds.height / 3)
                .edgesIgnoringSafeArea(.top)
            
            // Profile details
            VStack {
                // Profile image
                Image("luffy") // Replace with your profile image asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.top, -75) // Adjust padding to overlap the map view
                
                // User name
                Text("Mohan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Dummy information
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        Text("mohan@example.com")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.gray)
                        Text("+1 234 567 890")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Image(systemName: "house")
                            .foregroundColor(.gray)
                        Text("123 Main Street, City, Country")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
