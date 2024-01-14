//
//  TranslateResult.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation

struct TranslateResults: Decodable {
    var translations: [TranslateResult]
}

struct TranslateResult: Decodable {
    var detected_source_language: String
    var text: String
}

extension TranslateResults {
    func toDomain() -> [String] {
        return translations
            .map { $0.text }
    }
}
