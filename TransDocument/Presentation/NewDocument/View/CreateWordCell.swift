//
//  CreateWordCell.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import SwiftUI

struct CreateWordCell: View {
    let info: WordInfo
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .frame(width: 4, height: 4)
                .foregroundStyle(Colors.black001.toColor)
            
            Text(info.word)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Colors.black002.toColor)
            
            Spacer()
            
            Button(action: {
                action()
            }, label: {
                Image(systemName: "trash")
                    .resizable()
                    .foregroundStyle(Colors.black001.toColor)
                    .frame(width: 18, height: 18)
            })
            .buttonStyle(.plain)
        }
        .padding(12)
        .frame(height: 36)
    }
}

#Preview {
    CreateWordCell(info: .testInfo) {
        print("tap")
    }
}
