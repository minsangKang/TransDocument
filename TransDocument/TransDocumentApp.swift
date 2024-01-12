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
        let model = NewDocumentModel()
        WindowGroup {
            NewDocumentView(model: model)
        }
    }
}
