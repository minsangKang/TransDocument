//
//  GetWordsFromSentenceUseCase.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation

final class GetWordsFromSentenceUseCase: GetWordsFromSentenceUseCaseInterface {
    func getWords(from: String) -> [String] {
        return from.components(separatedBy: " ")
            .map { $0.replacingOccurrences(of: ".", with: "") }
            .map { $0.replacingOccurrences(of: ",", with: "") }
            .map { $0.replacingOccurrences(of: "(", with: "") }
            .map { $0.replacingOccurrences(of: ")", with: "") }
            .map { $0.replacingOccurrences(of: "-", with: " ") }
            .map { $0.replacingOccurrences(of: "—", with: " ") }
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
            .filter { !$0.isNumber }
    }
}
