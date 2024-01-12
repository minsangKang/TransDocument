//
//  String+Extension.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    
}
