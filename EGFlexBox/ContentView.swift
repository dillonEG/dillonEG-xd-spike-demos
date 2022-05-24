//
//  ContentView.swift
//  EGFlexBox
//
//  Created by Dillon on 5/24/22.
//

import SwiftUI

struct ContentView: View {
    let amenities: [Amenity] = Mock.amenities()
    
    var body: some View {
        VStack {
            ForEach(amenities) { item in
                AmenityView(item)
            }
        }
    }
}

struct AmenityView: View {
    let amenity: Amenity
    
    init(_ amenity: Amenity) {
        self.amenity = amenity
    }
    
    var body: some View {
        HStack {
            Image(amenity.glyphName)
            Text(amenity.label)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
