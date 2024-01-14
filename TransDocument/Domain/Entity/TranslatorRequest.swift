//
//  TranslatorRequest.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation

struct TranslatorRequest: Encodable {
    var text: [String]
    var target_lang: String
}
