//
//  AmenitiesBlockView.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AmenitiesBlockView: View {
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

struct AmenitiesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesBlockView()
    }
}
