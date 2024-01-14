//
//  NewDocumentWordsView.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import SwiftUI

struct NewDocumentWordsView: View {
    @ObservedObject var model: NewDocumentModel
    
    var body: some View {
        HStack(spacing: 8) {
            Rectangle()
                .foregroundStyle(Colors.gray001.toColor)
                .frame(width: 2)
            
            ScrollView {
                ForEach(Array(model.wordInfos.enumerated()), id: \.offset) { index, wordInfo in
                    CreateWordCell(info: wordInfo) {
                        model.delete(at: index)
                    }
                }
            }
        }
        .frame(width: 250)
    }
}

#Preview {
    NewDocumentWordsView(model: NewDocumentModel(
        textAdnustUseCase: TextAdjustUseCase(),
        sentenceAdjustUseCase: SentenceAdjustUseCase(),
        getWordsFromSentenceUseCase: GetWordsFromSentenceUseCase(),
        getTranslatedSentencesUseCase: GetTranslatedSentencesUseCase(repository: TranslatorRepository())
    ))
}
