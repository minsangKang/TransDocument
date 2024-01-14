//
//  GetTranslatedSentencesUseCase.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/14.
//

import Foundation
import Combine

final class GetTranslatedSentencesUseCase: GetTranslatedSentencesUseCaseInterface {
    let repository: TranslatorRepositoryInterface
    
    init(repository: TranslatorRepositoryInterface) {
        self.repository = repository
    }
    
    func getTranslatedSentencces(sentences: [String]) -> AnyPublisher<[String], NetworkError> {
        return repository.translate(sentences: sentences)
    }
}
