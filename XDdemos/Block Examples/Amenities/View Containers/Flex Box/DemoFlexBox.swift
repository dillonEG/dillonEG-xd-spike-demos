//
//  DemoFlexBox.swift
//  XDdemos
//
//  Created by Dillon on 5/31/22.
//

import SwiftUI

struct DemoFlexBox: View {
    let amenities: [Amenity] = Amenity.mock()
    let nums = Array<Int>(0...400)
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            Text("Squares Demo")
                .amenityTextLabel(.title)
            
            
            FlexBox(nums, flexDirection: .column) { num in
                DemoFlexSquare(num: num)
                    .fixedSize()
            }
            
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: 800)
    }
}

struct DemoFlexSquare: View {
    let num: Int
    
    let colors: [Color] = [.red, .orange, .purple, .pink, .blue, .green, .yellow]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(colors.randomElement() ?? .black)
            .frame(width: CGFloat.random(in: 24...120), height: 60)
            .padding(4)
            .overlay(Text("\(num)"))
    }
}


struct DemoFlexBox_Previews: PreviewProvider {
    static var previews: some View {
        DemoFlexBox()
        
        DemoFlexBox()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
