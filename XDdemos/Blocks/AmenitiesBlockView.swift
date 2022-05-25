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
        VStack(alignment: .leading, spacing: 14) {
            Text("Amenities")
                .font(.custom("AvenirNext-Medium", size: 24))
            
            ForEach(amenities, id: \.self) { amenity in
                AmenityView(amenity)
            }
            
            Button {
                // do something
            } label: {
                Text("See all")
                    .font(.custom("AvenirNext-Regular", size: 14))
                    .underline()
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
        HStack(spacing: 9.5) {
            Image(amenity.glyphName)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(red: 52 / 255, green: 59 / 255, blue: 83 / 255, opacity: 1))
                .frame(width: 15, height: 15)
            
            Text(amenity.label)
                .font(.custom("AvenirNext-Regular", size: 14))
        }
    }
}

struct AmenitiesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesBlockView()
    }
}
