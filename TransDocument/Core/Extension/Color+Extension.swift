//
//  Color+Extension.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import SwiftUI

extension Color {
    public init?(hex: String) {
        let r, g, b: CGFloat

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat((hexNumber & 0x0000ff)) / 255

            self.init(red: r, green: g, blue: b)
            return
        }
        
        return nil
    }
}
