//
//  Infos.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation

enum Infos: String {
    case DeepL_Key
    
    var value: String {
        return Bundle.main.infoDictionary?[self.rawValue] as? String ?? ""
    }
}
