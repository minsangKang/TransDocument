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
        ZStack(alignment: .top) {
            Color.white
            
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
                    isEditable: model.isEditable,
                    font: .userFixedPitchFont(ofSize: 14)
                )
                .border(Colors.gray001.toColor, width: 1)
                
                HStack {
                    Spacer()
                    TDSubmitButton(selectable: $model.submitSelectable) {
                        model.submit()
                    }
                }
            }
            .padding(32)
        }
        .frame(minWidth: 450, minHeight: 500)
    }
}

#Preview {
    NewDocumentView(model: NewDocumentModel())
}
