//
//  TDSubmitButton.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import SwiftUI

struct TDSubmitButton: View {
    @Binding var selectable: Bool
    @Binding var isRun: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(isRun ? "Run" : "Save")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(selectable ? Colors.black001.toColor : Colors.gray002.toColor)
        })
        .buttonStyle(.plain)
        .allowsHitTesting(selectable)
    }
}

#Preview {
    struct Preview: View {
        @State var selectable: Bool = true
        @State var isRun: Bool = true
        var body: some View {
            TDSubmitButton(selectable: $selectable, isRun: $isRun, action: {
                print("tap")
            })
        }
    }
    
    return Preview()
}
