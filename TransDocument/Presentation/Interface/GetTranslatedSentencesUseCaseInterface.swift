//
//  GetTranslatedSentencesUseCaseInterface.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation
import Combine

protocol GetTranslatedSentencesUseCaseInterface {
    var repository: TranslatorRepositoryInterface { get }
    func getTranslatedSentencces(sentences: [String]) -> AnyPublisher<[String], NetworkError>
}
