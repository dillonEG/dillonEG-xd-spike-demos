//
//  AmenityItem.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

struct AmenityItem: View {
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
                .foregroundColor(.neutral1_700)
                .frame(width: 15, height: 15)
            
            Text(amenity.label)
                .amenityTextLabel()
        }
    }
}

struct AmenityLabel: ViewModifier {
    let style: FontStyle
    let accent: AccentStyle
    
    enum FontStyle: String {
        case title = "AvenirNext-Medium"
        case description = "AvenirNext-Regular"
    }
    
    enum AccentStyle {
        case none
        case textLink
    }
    
    init(_ style: AmenityLabel.FontStyle, accent: AccentStyle = .none) {
        self.style = style
        self.accent = accent
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(style.rawValue, size: style == .description ? 14 : 24))
            .foregroundColor(accent == .textLink ? .accent1_500 : nil)
            .foregroundColor(style == .title ? .neutral1_900 : .neutral1_700)
    }
}

struct AmenityItem_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = Amenity.mock()
        
        Group {
            ForEach(amenities, id: \.self) { amenity in
                AmenityItem(amenity)
            }
        }
        .previewLayout(.fixed(width: 200, height: 50))
    }
}
