//
//  AmenitiesAdaptiveGrid.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AmenitiesAdaptiveGrid: View {
    @State private var show: Bool = false
    let amenities: [Amenity] = Amenity.mock()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 14) {
            Text("Amenities")
                .amenityTextLabel(.title)
            
            AdaptiveGroup(amenities, flexDirection: .column, itemSize: .minimum(180)) { amenity in
                AmenityItem(amenity)
                    .background(show ? .orange : .clear)
            }
            .background(show ? .blue : .clear)

            amenityButton(label: "See all", control: _show)
        }
        .padding(.horizontal, 24)
        .background(show ? .purple : .clear)
    }
    
    
    func amenityButton(label: String, control: State<Bool>) -> some View {
        Button {
            control.wrappedValue.toggle()
        } label: {
            Text(label)
                .amenityTextLabel(accent: .textLink)
        }
    }
}

struct AmenitiesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesAdaptiveGrid()
    }
}
