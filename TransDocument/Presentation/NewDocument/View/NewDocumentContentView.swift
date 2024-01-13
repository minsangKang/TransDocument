//
//  NewDocumentContentView.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import SwiftUI

struct NewDocumentContentView: View {
    @ObservedObject var model: NewDocumentModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .bottom, spacing: 16) {
                TextField("TITLE", text: $model.title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Colors.black001.toColor)
                    .textFieldStyle(.plain)
                
                Text(Date().yy_MM_dd)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Colors.black002.toColor)
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Colors.gray001.toColor)
            
            TextField("URL", text: $model.url)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Colors.black002.toColor)
                .textFieldStyle(.plain)
            
            Spacer()
                .frame(height: 8)
            
            TDEditTextView(
                text: $model.text,
                isEditable: $model.isEditable,
                font: .userFixedPitchFont(ofSize: 14)
            )
            .border(Colors.gray001.toColor, width: 1)
            
            HStack {
                Spacer()
                TDSubmitButton(selectable: $model.submitSelectable, isRun: $model.isEditable) {
                    if model.isEditable {
                        model.submit()
                        withAnimation {
                            model.isEditable = false
                        }
                    } else {
                        model.save()
                    }
                }
            }
        }
        .padding(32)
    }
}

#Preview {
    struct Preview: View {
        @StateObject var model = NewDocumentModel(
            textAdnustUseCase: TextAdjustUseCase(),
            sentenceAdjustUseCase: SentenceAdjustUseCase(),
            getWordsFromSentenceUseCase: GetWordsFromSentenceUseCase()
        )
        var body: some View {
            NewDocumentContentView(model: model)
        }
    }
    return Preview()
}
