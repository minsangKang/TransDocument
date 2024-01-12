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
    @Published var text: String = ""
    @Published var isEditable: Bool = true
    @Published var submitSelectable: Bool = false
    
    private let textAdjustUseCase: TextAdjustUseCaseInterface
    private var cancellables: Set<AnyCancellable> = []
    
    init(textAdnustUseCase: TextAdjustUseCaseInterface) {
        self.textAdjustUseCase = textAdnustUseCase
        self.bind()
    }
    
    private func bind() {
        self.$title
            .sink { [weak self] _ in
                self?.updateSubmitSelectable()
            }
            .store(in: &cancellables)
        
        self.$text
            .sink { [weak self] _ in
                self?.updateSubmitSelectable()
            }
            .store(in: &cancellables)
    }
    
    private func updateSubmitSelectable() {
        self.submitSelectable = (!title.isEmpty && !text.isEmpty)
    }
}

// MARK: Input
extension NewDocumentModel {
    func submit() {
        self.text = self.textAdjustUseCase.adjustText(from: self.text)
        print("title: \(title)")
        print("url: \(url)")
        print("text: \(text)")
        self.isEditable = false
    }
}
