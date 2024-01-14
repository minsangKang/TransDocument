//
//  TransDocumentApp.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import SwiftUI

@main
struct TransDocumentApp: App {
    var body: some Scene {
        let textAdjustUseCase = TextAdjustUseCase()
        let sentenceAdjustUseCase = SentenceAdjustUseCase()
        let getWordsFromSentenceUseCase = GetWordsFromSentenceUseCase()
        let getTranslatedSentencesUseCase = GetTranslatedSentencesUseCase(repository: TranslatorRepository())
        
        let model = NewDocumentModel(
            textAdnustUseCase: textAdjustUseCase,
            sentenceAdjustUseCase: sentenceAdjustUseCase,
            getWordsFromSentenceUseCase: getWordsFromSentenceUseCase,
            getTranslatedSentencesUseCase: getTranslatedSentencesUseCase
        )
        WindowGroup {
            NewDocumentView(model: model)
        }
    }
}
