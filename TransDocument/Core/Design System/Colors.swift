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
    case black001 = "#2A2A2A"
    
    var toColor: Color {
        return Color.init(hex: self.rawValue) ?? .blue
    }
}
