//
//  NewDocumentView.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import SwiftUI

struct NewDocumentView: View {
    @StateObject private var model: NewDocumentModel
    
    init(model: NewDocumentModel) {
        self._model = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
            HStack(spacing: 0) {
                NewDocumentContentView(model: model)
                
                NewDocumentWordsView(model: model)
                    .frame(width: model.isEditable ? 0 : 250)
                    .opacity(model.isEditable ? 0 : 1)
                    .animation(.easeIn, value: model.isEditable)
            }
        }
        .frame(minWidth: 700, minHeight: 500)
    }
}

#Preview {
    NewDocumentView(model: NewDocumentModel(
        textAdnustUseCase: TextAdjustUseCase(),
        sentenceAdjustUseCase: SentenceAdjustUseCase(),
        getWordsFromSentenceUseCase: GetWordsFromSentenceUseCase())
    )
}
