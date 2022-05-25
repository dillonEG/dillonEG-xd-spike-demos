//
//  HomeNavigationView.swift
//  XDdemos
//
//  Created by Dillon on 5/24/22.
//

import SwiftUI

struct HomeNavigationView: View {
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: NavigationToolbarView()) {
                    Text("Navigation toolbar")
                }
                
                NavigationLink(destination: AmenitiesBlockView()) {
                    Text("Amenities blocks")
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Spike Demos", displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationView()
    }
}
