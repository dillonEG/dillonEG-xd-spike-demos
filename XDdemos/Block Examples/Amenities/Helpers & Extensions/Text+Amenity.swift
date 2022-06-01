//
//  Text+Amenity.swift
//  XDdemos
//
//  Created by Dillon on 5/25/22.
//

import SwiftUI

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
