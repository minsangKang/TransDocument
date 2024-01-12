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
        let model = NewDocumentModel(textAdnustUseCase: textAdjustUseCase, sentenceAdjustUseCase: sentenceAdjustUseCase)
        WindowGroup {
            NewDocumentView(model: model)
        }
    }
}
