//
//  WordInfo.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

struct WordInfo: Identifiable {
    var id: UUID
    var word: String
    var check: Bool
    var sentenceIndex: Int
    
    init(word: String, sentenceIndex: Int) {
        self.id = UUID()
        self.word = word
        self.check = true
        self.sentenceIndex = sentenceIndex
    }
    
    mutating func toggle() {
        self.check.toggle()
    }
}

extension WordInfo {
    static var testInfo: WordInfo {
        return .init(
            word: "hello", sentenceIndex: 0
        )
    }
}
