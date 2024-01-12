//
//  SentenceAdjustUseCase.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

final class SentenceAdjustUseCase: SentenceAdjustUseCaseInterface {
    func adjustSentence(from: String) -> [String] {
        var stringValue = from
        if stringValue.contains("\n\n") {
            stringValue = from.replacingOccurrences(of: "\n\n", with: "\n")
        }
        if stringValue.contains(". ") {
            stringValue = from.replacingOccurrences(of: ". ", with: ".\n")
        }
        
        return stringValue.components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
    }
}
