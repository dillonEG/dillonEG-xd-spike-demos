//
//  AmenitiesBlockView.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AmenitiesBlockView: View {
    let amenities: [Amenity] = Amenity.mock()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Amenities")
                .amenityTextLabel(.title)
            
            ForEach(amenities, id: \.self) { amenity in
                AmenityItem(amenity)
            }
            
            Button {
                // do something
            } label: {
                Text("See all")
                    .amenityTextLabel(accent: .textLink)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }
}

struct AmenitiesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesBlockView()
    }
}
