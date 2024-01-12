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
                    TextField("Title", text: $model.title)
                        .font(.largeTitle)
                        .foregroundStyle(Colors.black001.toColor)
                        .textFieldStyle(.plain)
                    
                    Text(Date().yy_MM_dd)
                        .font(.subheadline)
                        .foregroundStyle(Colors.black001.toColor)
                }
                
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Colors.gray001.toColor)
                
                TextField("url", text: $model.url)
                    .font(.title3)
                    .foregroundStyle(Colors.black001.toColor)
                    .textFieldStyle(.plain)
                
                Spacer()
                    .frame(height: 8)
                
                ZStack {
                    Colors.gray001.toColor.opacity(0.1)
                    
                    Text("TextView")
                        .font(.body)
                        .foregroundStyle(Colors.black001.toColor)
                }
                .frame(height: 300)
            }
            .padding(32)
        }
        .frame(minWidth: 500, minHeight: 600)
    }
}

#Preview {
    NewDocumentView(model: NewDocumentModel())
}
