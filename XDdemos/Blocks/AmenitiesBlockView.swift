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
                .amenityTextLabel(.title)
            
            ForEach(amenities, id: \.self) { amenity in
                AmenityView(amenity)
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
                .foregroundColor(.neutral1_700)
                .frame(width: 15, height: 15)
            
            Text(amenity.label)
                .amenityTextLabel()
        }
    }
}

struct AmenityLabel: ViewModifier{
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
            .foregroundColor(
                accent == .textLink ? .accent1_500 : (
                    style == .title ? .neutral1_900 : .neutral1_700
                )
            )
    }
}

extension Text {
    func amenityTextLabel(
        _ size: AmenityLabel.FontStyle = .description,
        accent: AmenityLabel.AccentStyle = .none
    ) -> some View {
        self
            .underline(accent == .textLink ? true : false)
            .modifier(AmenityLabel(size, accent: accent))
    }
}

extension Color {
    static let neutral1_900 = Color(red: 20 / 255, green: 29 / 255, blue: 56 / 255, opacity: 1)
    static let neutral1_700 = Color(red: 52 / 255, green: 59 / 255, blue: 83 / 255, opacity: 1)
    static let accent1_500 = Color(red: 54 / 255, green: 98 / 255, blue: 216 / 255, opacity: 1)
}

struct AmenitiesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesBlockView()
    }
}
