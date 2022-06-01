//
//  ItemSize.swift
//  XDdemos
//
//  Created by Dillon on 6/1/22.
//

import SwiftUI

struct AdaptiveItemSize {
    let min: CGFloat
    let max: CGFloat
    
    private init(min: CGFloat, max: CGFloat) {
        self.min = min
        self.max = max
    }
    
    static let defaultRow = AdaptiveItemSize(min: 40, max: .infinity)
    static let defaultColumn = AdaptiveItemSize(min: 192, max: .infinity)
    
    static func minimum(_ minSize: CGFloat) -> AdaptiveItemSize {
        return AdaptiveItemSize(min: minSize, max: .infinity)
    }
    
    static func adaptive(min: CGFloat, max: CGFloat) -> AdaptiveItemSize {
        return AdaptiveItemSize(min: min, max: max)
    }
}
