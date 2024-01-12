//
//  Colors.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation
import SwiftUI

enum Colors: String {
    case gray001 = "#CECECE"
    case gray002 = "#DFDFDF"
    
    case black001 = "#2A2A2A"
    case black002 = "#555555"
    
    var toColor: Color {
        return Color.init(hex: self.rawValue) ?? .blue
    }
}
