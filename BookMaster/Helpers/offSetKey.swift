//
//  offSetKey.swift
//  BookMaster
//
//  Created by Mac mini on 22.09.2024.
//

import Foundation
import SwiftUI
struct OffSetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
