//
//  NewDocumentModel.swift
//  TransDocument
//
//  Created by Kang Minsang on 2024/01/12.
//

import Foundation
import Combine

final class NewDocumentModel: ObservableObject {
    @Published var title: String = ""
    @Published var url: String = ""
}
